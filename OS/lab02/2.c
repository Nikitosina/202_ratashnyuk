#include <stdio.h>
#include <stdlib.h>

void printIntArray(int n, int* arr) {
    for (int i = 0; i < n - 1; i++) {
        printf("%d, ", arr[i]);
    }
    printf("%d", arr[n - 1]);
}

int main() {
    int n;
    printf("Enter array size:\n");
    scanf("%d", &n);

    int* array = malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &array[i]);
    }
    for (int i = 0; i < n / 2; i++) {
        int temp = array[i];
        array[i] = array[n - i - 1];
        array[n - i - 1] = temp;
    }
    printIntArray(n, array);
    free(array);

    return 0;
}