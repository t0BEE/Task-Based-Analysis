#include <hpx/hpx_init.hpp>
#include <hpx/include/iostreams.hpp>
#include <hpx/include/async.hpp>
#include <chrono>

long long fibonacci(long long input) {
	if (input < 2) return input;

	hpx::future<long long> n1 = hpx::async(fibonacci, input - 1);
	hpx::future<long long> n2 = hpx::async(fibonacci, input - 2);
	return n1.get() + n2.get();
}

int hpx_main(hpx::program_options::variables_map& vm) {
    // extract command line arguments
    int fibNumber = vm["n-value"].as<int>();

    auto start = std::chrono::high_resolution_clock::now();

    // call fibonacci function
    long long result = fibonacci((long long) fibNumber);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    hpx::cout << "Execution time: " << duration.count() << "\n" << hpx::flush;

    // output result for debugging
    hpx::cout << result << "\n" << hpx::flush;

    // shutdoen HPX environment
    return hpx::finalize();

}


int main(int argc, char *argv[]){
    // Configure application-specific options
    hpx::program_options::options_description
       desc_commandline("Usage: " HPX_APPLICATION_STRING " [options]");

    desc_commandline.add_options()
        ( "n-value",
          hpx::program_options::value<int>()->default_value(10),
          "n value for the Fibonacci function");

    // Init and run HPX runtime environment
    return hpx::init(desc_commandline, argc, argv);
}
