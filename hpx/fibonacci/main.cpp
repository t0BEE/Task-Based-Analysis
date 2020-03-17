#include <hpx/hpx_main.hpp>
#include <hpx/include/iostreams.hpp>
#include <hpx/include/async.hpp>
#include <chrono>

long long fibonacci(long long input) {
	if (input < 2) return input;

	hpx::future<long long> n1 = hpx::async(fibonacci, input - 1);
	hpx::future<long long> n2 = hpx::async(fibonacci, input - 2);
	return n1.get() + n2.get();
}

int main(int argc, char *argv[]){
    // parse parameters
    // only one parameter of which the fibonacci number shall be calculated
    if (argc != 2) {
        hpx::cout << "Parameters do not match!" << "\n" << hpx::flush;
        return -1;
    }
    int fibNumber = atoi(argv[1]);

    auto start = std::chrono::high_resolution_clock::now();

    // call fibonacci function
    long long result = fibonacci((long long) fibNumber);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    hpx::cout << "Execution time: " << duration.count() << "\n" << hpx::flush;

    // output result for debugging
    hpx::cout << result << "\n" << hpx::flush;

    return 0;
}
