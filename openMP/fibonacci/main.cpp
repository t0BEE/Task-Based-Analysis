#include <chrono>
#include <iostream>


int fibonacci(int input) {
    if (input < 2 ) return input;

    int x, y;
    #pragma omp parallel
    {
        #pragma omp single
	{
            #pragma omp task
            {
                x = fibonacci(input - 1);
            }
            #pragma omp task
            {
                y = fibonacci(input - 2);
            }
        }
    }
    return x + y;
}


int main(int argc, char *argv[]) {

    // parse parameters
    // only one parameter of which the fibonacci number shall be calculated
    if (argc != 2) {
        std::cout << "Parameters do not match!" << std::endl;
	return -1;
    }
    int fibNumber = atoi(argv[1]);

    auto start = std::chrono::high_resolution_clock::now();

    // call fibonacci function
    int result = fibonacci(fibNumber);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Execution time: " << duration.count() << std::endl;

    // output result for debugging
    std::cout << result << std::endl;

    return 0;
}
