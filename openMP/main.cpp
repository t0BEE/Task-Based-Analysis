#include <iostream>
#include <cstdlib>
#include <cmath>

#define VECTOR_SIZE 100


float vectors[2][VECTOR_SIZE];

void sum_vector(int vectorIndex, int depth = 1){
    int stepSize = (int) pow( 2, depth);
    if (stepSize > VECTOR_SIZE) return;
    for(int i = 0; i < VECTOR_SIZE; i+=stepSize){
    // the amount of tasks it not always dividable by 2,
    // the result of the last task has to be added to the previous result
    // this is the case if the modulo calculation of the vector size is greater or equal to the half of the step size
        if(i > VECTOR_SIZE - stepSize) {
            if (VECTOR_SIZE % stepSize >= stepSize / 2) {
                vectors[vectorIndex][i - stepSize] += vectors[vectorIndex][i];
            }
            break;
        }
        vectors[vectorIndex][i] += vectors[vectorIndex][i+(stepSize/2)];
    }
    sum_vector(vectorIndex, depth + 1);
}

int main(int argc, char *argv[]) {
    // parse parameters
    // first parameter: how often calculate from one vector to another
    // second parameter: task size (how many tasks per vector, VECTOR_SIZE/task size)
    if (argc != 3){
        std::cout << "Some parameters are missing!" << std::endl;
        return -1;
    }
    int turns = atoi(argv[1]);
    int taskSize = atoi(argv[2]);

    // seed the random number generator with a constant to create a deterministic generation
    srand(42);

    // fill the first vector
    for(float & i : vectors[0]){
        i = fabsf(float(rand()) / float(RAND_MAX) * 100);
    }

    // start the actual benchmark workload
    for(int i = 0; i < turns; i++){
        for(int j = 0; j < VECTOR_SIZE; j++){
            vectors[(i + 1) % 2][j] = fabsf(std::sin(vectors[i % 2][j])) * 100;
        }
    }

    // aggregate the vector elements in a parallel tree structure
    // if turns mod 2 = 0, results are in vector at 0
    sum_vector(turns % 2);

    return 0;
}
