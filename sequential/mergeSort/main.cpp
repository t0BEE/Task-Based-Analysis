#include <iostream>
#include <chrono>
#include <cstdlib>
#include <cmath>

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
    mergeSort(left, middle);
    mergeSort(middle + 1, right);
    merge(left, middle, right);
}

int main(int argc, char *argv[]) {
    // if parameter is 0, use debug mode
    int debug = 0;
    if (argc == 2) {
        int param = atoi(argv[1]);
	if (param == 0) debug = 1;
    }
    int debugB = 0;
    if (argc == 2){
        char* debugflag = argv[2];
        if (strcmp("--debug"),debugflag) debugB = 1;
    }


    // seed the random number generator with a constant to create a deterministic generation
    srand(42);
    for(int & i : vector) {
        i = (int) std::ceil(fabsf(float(rand()) / float(RAND_MAX) * 1000));
    }
    
    auto start = std::chrono::high_resolution_clock::now();


    mergeSort(0, VECTOR_SIZE - 1);

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end-start);
    if (debugB) std::cout << "Execution time: " << duration.count() << " ms"<< std::endl;
    else std::cout << duration.count() << std::endl;


    if (debug) {
        for(int l = 0; l < VECTOR_SIZE; l++){
            std::cout << vector[l] << ", ";
	}
	std::cout << std::endl;
    }
    return 0;
}
