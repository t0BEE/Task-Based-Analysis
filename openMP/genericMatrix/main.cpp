#include <iostream>
#include <cstdlib>
#include <cmath>
#include <chrono>
#include <cstring>
#include <omp.h>


float vectors[2][VECTOR_SIZE];

void sum_vector(int vectorIndex, int depth = 1){
    int stepSize = (int) pow( 2, depth);
    if (stepSize > VECTOR_SIZE) return;
        #pragma omp taskloop untied
        for (int i = 0; i < VECTOR_SIZE; i += stepSize) {
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
        }
    sum_vector(vectorIndex, depth + 1);
}


int main(int argc, char *argv[]) {
    // parse parameters
    // first parameter: how often calculate from one vector to another
    // second parameter: task size (how many tasks per vector, VECTOR_SIZE/task size)
    // provide --debug as second parameter for a more beautiful output
    int debug = 0;
    if (argc == 4){
        char* debugflag = argv[3];
        if (!strcmp("--debug",debugflag)) debug = 1;
    }
    if (argc > 4 || (argc == 4 && debug == 0)){
        std::cout << "Some parameters are missing!" << std::endl;
        return -1;
    }

    int turns = atoi(argv[1]);
    int taskSize = atoi(argv[2]);

    // seed the random number generator with a constant to create a deterministic generation
    srand(42);

    // fill the first vector
    for(float & i : vectors[0]){
        i = fabsf(float(rand()) / float(RAND_MAX) * 10);
    }

    //start time tracking
    auto start = std::chrono::high_resolution_clock::now();

    // matrix size
    int matrixSize = taskSize * taskSize;

    // start the actual benchmark workload
    for(int i = 0; i < turns; i++){
	#pragma omp parallel
        {
	    #pragma omp single
            {
		for (int k = 0; k < VECTOR_SIZE - 1; k++) {
		    #pragma omp task
		    {
		        float res = 0.0;
			for(int j = 0; j < matrixSize - 1; j++) {
			    res += fabsf(std::sin(vectors[i % 2][k])) * j;
			}
			vectors[(i + 1) % 2][k] = res;
		    }
		}
	    }
        }
    }

    // aggregate the vector elements in a parallel tree structure
    // if turns mod 2 = 0, results are in vector at 0
    sum_vector(turns % 2);


    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    if (debug) std::cout << "Execution time: " << duration.count() << " ms"<< std::endl;
    else std::cout << duration.count();

    // Output the solution for debugging
    if (debug) std::cout << vectors[0][0] << std::endl;

    return 0;
}
