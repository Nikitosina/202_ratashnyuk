#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>

// HOW TO USE:
// Provide an argument in command line which is divisible by 4

static int size = 0;
static int sum = 0;
static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

void printArray(int n, int* array) {
    printf("[");
    for (int i = 0; i < n - 1; i++) {
        printf("%d, ", array[i]);
    }
    printf("%d]\n", array[n - 1]);
}

int* fillPartArray(int n, int* baseArray, int partNumber) {
    int* part = malloc(sizeof(int) * (n / 4));
    for (int i = 0; i < n / 4; i++) {
        part[i] = baseArray[i + (n / 4 * partNumber)];
    }
    return part;
}

static void * sumFunc(void *arg) {
    int s, localSum = 0;
    int* array = (int *) arg;
    for (int i = 0; i < size / 4; i++) {
        localSum += array[i];
    }

    s = pthread_mutex_lock(&mtx);
    if (s != 0) {
        perror("pthread_mutex_lock");
        return NULL;
    }

    sum += localSum;
    
    s = pthread_mutex_unlock(&mtx);
    if (s != 0) {
        perror("pthread_mutex_unlock");
        return NULL;
    }

    return NULL;
}

int main(int argc, char *argv[]) {
    pthread_t t1, t2, t3, t4;
    int n = (argc > 1) ? atoi(argv[1]) : 16;
    int min = 0;
    int max = 100;
    int s;
    size = n;

    int* array = malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        array[i] = rand() % (max + 1 - min) + min;
    }

    int* part1 = fillPartArray(n, array, 0);
    int* part2 = fillPartArray(n, array, 1);
    int* part3 = fillPartArray(n, array, 2);
    int* part4 = fillPartArray(n, array, 3);
    // int* part4 = malloc(sizeof(int) * (n / 4 + n % 4));

    printArray(n, array);
    printf("Part 1: ");
    printArray(n / 4, part1);
    printf("Part 2: ");
    printArray(n / 4, part2);
    printf("Part 3: ");
    printArray(n / 4, part3);
    printf("Part 4: ");
    printArray(n / 4, part4);

    s = pthread_create(&t1, NULL, sumFunc, (void*)part1);
    if (s != 0) {
        perror("pthread_create");
        return -1;
    }
    s = pthread_create(&t2, NULL, sumFunc, (void*)part2);
    if (s != 0) {
        perror("pthread_create");
        return -1;
    }
    s = pthread_create(&t3, NULL, sumFunc, (void*)part3);
    if (s != 0) {
        perror("pthread_create");
        return -1;
    }
    s = pthread_create(&t4, NULL, sumFunc, (void*)part4);
    if (s != 0) {
        perror("pthread_create");
        return -1;
    }
    s = pthread_join(t1, NULL);
    if (s != 0) {
        perror("pthread_join");
        return -1;
    }
    s = pthread_join(t2, NULL);
    if (s != 0) {
        perror("pthread_join");
        return -1;
    }
    s = pthread_join(t3, NULL);
    if (s != 0) {
        perror("pthread_join");
        return -1;
    }
    s = pthread_join(t4, NULL);
    if (s != 0) {
        perror("pthread_join");
        return -1;
    }
    
    printf("Result = %d\n", sum);
    return 0;
}