#include <chrono>
#include <iostream>
#include <cstring>
#include <omp.h>


long long fibonacci(long long input) {
    if (input < 2 ) return input;

    long long x, y;
    #pragma omp task shared(x) firstprivate(input)
    x = fibonacci(input - 1);
    #pragma omp task shared(y) firstprivate(input)
    y = fibonacci(input - 2);
    #pragma omp taskwait
    return x + y;
}


int main(int argc, char *argv[]) {
    // parse parameters
    // only one parameter of which the fibonacci number shall be calculated
    // provide --debug as second parameter for a more beautiful output
    int debug = 0;
    if (argc == 3){
        char* debugflag = argv[2];
        if (!strcmp("--debug",debugflag)) debug = 1;
    }
    if (argc > 3 || (argc == 3 && debug == 0)){
        std::cout << "Parameters do not match!" << std::endl;
        return -1;
    }
    int fibNumber = atoi(argv[1]);

    auto start = std::chrono::high_resolution_clock::now();

    // call fibonacci function
    long long result = fibonacci((long long) fibNumber);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    if (debug) std::cout << "Execution time: " << duration.count() << " ms"<< std::endl;
    else std::cout << duration.count();

    // output result for debugging
    if (debug) std::cout << result << std::endl;

    return 0;
}
