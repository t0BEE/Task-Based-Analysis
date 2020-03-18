#include <iostream>
#include <chrono>
#include <cstdlib>
#include <cmath>
#include <hpx/hpx_init.hpp>
#include <hpx/include/iostreams.hpp>
#include <hpx/include/async.hpp>

#define VECTOR_SIZE 10000

int vector[VECTOR_SIZE];

void merge(int left, int middle, int right) {
    int size_1 = middle - left + 1;
    int size_2 = right - middle;

    // temporary arrays
    int Left[size_1];
    int Right[size_2];

    // copy the actual sub arrays in the temporaries
    for(int i = 0; i < size_1; i++) {
        Left[i] = vector[left + i];
    }
    for(int j = 0; j < size_2; j++) {
        Right[j] = vector[middle + 1 + j];
    }

    // merge the two sub arrays back into the original
    int i = 0, j = 0, k = left;
    while(i < size_1 && j < size_2) {
        if(Left[i] <= Right[j]) {
            vector[k] = Left[i];
	    i++;
	} else {
            vector[k] = Right[j];
	    j++;
	}
	k++;
    }

    // copy remaining elements if there are any
    while(i < size_1) {
        vector[k] = Left[i];
	i++;
	k++;
    }
    while(j < size_2) {
        vector[k] = Right[j];
	j++;
	k++;
    }

}

void mergeSort(int left, int right) {
    if(!(left < right)) return;
    int middle = (left + right) / 2;
    hpx::future<void> m1 = hpx::async(mergeSort, left, middle);
    hpx::future<void> m2 = hpx::async(mergeSort, middle + 1, right);
    m1.get();
    m2.get();
    merge(left, middle, right);
}

int hpx_main(hpx::program_options::variables_map& vm) {
    // if parameter is 0, use debug mode
    int debug = vm["debug"].as<int>();
    

    // seed the random number generator with a constant to create a deterministic generation
    srand(42);
    for(int & i : vector) {
        i = (int) std::ceil(fabsf(float(rand()) / float(RAND_MAX) * 1000));
    }
    
    auto start = std::chrono::high_resolution_clock::now();


    mergeSort(0, VECTOR_SIZE - 1);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end-start);
    hpx::cout << "Execution time: " << duration.count() << "\n" << hpx::flush;

    if (debug) {
        for(int l = 0; l < VECTOR_SIZE; l++){
            hpx::cout << vector[l] << ", ";
	}
	hpx::cout << "\n" << hpx::flush;
    }
    return hpx::finalize();
}


int main(int argc, char *argv[]) {
    // Configure application-specific options
    hpx::program_options::options_description
       desc_commandline("Usage: " HPX_APPLICATION_STRING " [options]");

    desc_commandline.add_options()
        ( "debug",
          hpx::program_options::value<int>()->default_value(0),
          "If set, use degug mode");

    // Init and run HPX runtime environment
    return hpx::init(desc_commandline, argc, argv);
}
