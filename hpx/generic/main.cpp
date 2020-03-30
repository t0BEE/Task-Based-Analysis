#include <iostream>
#include <cstdlib>
#include <cmath>
#include <chrono>
#include <hpx/hpx_init.hpp>
#include <hpx/include/iostreams.hpp>
#include <hpx/include/async.hpp>
#include <hpx/parallel/algorithms/for_loop.hpp>
#include <hpx/parallel/execution_policy.hpp>


float vectors[2][VECTOR_SIZE];

void sum_vector(int vectorIndex, int depth = 1){
    int stepSize = (int) pow( 2, depth);
    if (stepSize > VECTOR_SIZE) return;
    hpx::future<void> loop = hpx::parallel::v2::for_loop_strided(
	hpx::parallel::execution::parallel_task_policy(),
	0, VECTOR_SIZE, stepSize, [&](int i)
	{
            // the amount of tasks it not always dividable by 2,
            // the result of the last task has to be added to the previous result
            // this is the case if the modulo calculation of the vector size is greater or equal to the half of the step size
            if (i > VECTOR_SIZE - stepSize) {
            	if (VECTOR_SIZE % stepSize >= stepSize / 2) {
             	    vectors[vectorIndex][i - stepSize] += vectors[vectorIndex][i];
            	}
            } else {
                vectors[vectorIndex][i] += vectors[vectorIndex][i + (stepSize / 2)];
            }
	});
    loop.get();
    sum_vector(vectorIndex, depth + 1);
}


int hpx_main(hpx::program_options::variables_map& vm) {

    int turns = vm["turns"].as<int>();
    int taskSize = vm ["taskSize"].as<int>();
    int debug = vm["debug"].as<int>();

    // seed the random number generator with a constant to create a deterministic generation
    srand(42);

    // fill the first vector
    for(float & i : vectors[0]){
        i = fabsf(float(rand()) / float(RAND_MAX) * 10);
    }

    // start time tracking
    auto start = std::chrono::high_resolution_clock::now();

    // start the actual benchmark workload
    for(int i = 0; i < turns; i++){
        int nrTasks = (int) std::ceil(VECTOR_SIZE / taskSize);

        hpx::future<void> loop = hpx::parallel::v2::for_loop(
	    hpx::parallel::execution::parallel_task_policy(),
	    0, nrTasks - 1, [&](int k){
	        for(int j = k * taskSize; j < (k + 1) * taskSize; j++) {
                    vectors[(i + 1) % 2][j] = fabsf(std::sin(vectors[i % 2][j])) * 10;
		}
	});

	for(int j = (nrTasks - 1) * taskSize; j < VECTOR_SIZE; j++) {
            vectors[(i + 1) % 2][j] = fabsf(std::sin(vectors[i % 2][j])) * 10;
	}
	loop.get();
    }

    // aggregate the vector elements in a parallel tree structure
    // if turns mod 2 = 0, results are in vector at 0
    sum_vector(turns % 2);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);

    if (debug) hpx::cout << "Execution time: " << duration.count() << "\n" << hpx::flush;
    else hpx::cout << duration.count() << hpx::flush;

    // output result for debugging
    if (debug) hpx::cout << vectors[0][0] << "\n" << hpx::flush;

    return hpx::finalize();
}

int main(int argc, char *argv[]){
    // parse parameters
    // Configure application-specific options
    hpx::program_options::options_description
       desc_commandline("Usage: " HPX_APPLICATION_STRING " [options]");

    desc_commandline.add_options()
        ( "turns",
          hpx::program_options::value<int>()->default_value(10),
          "specifies how often vectors are copied");

    desc_commandline.add_options()
        ( "taskSize",
          hpx::program_options::value<int>()->default_value(10),
          "specifies how many vector elements are used by a task");

    desc_commandline.add_options()
        ( "debug",
          hpx::program_options::value<int>()->default_value(0),
          "provide this flag to gain more information about the execution");

    // Init and run HPX runtime environment
    return hpx::init(desc_commandline, argc, argv);
}
