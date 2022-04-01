#include <stdio.h>
#include <stdlib.h>

void swap(int* x, int* y) {
    int temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

int main() {
    int n, m;
    scanf("%d", &n);
    scanf("%d", &m);

    int* matrix = malloc(sizeof(int) * n * m);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            scanf("%d", &matrix[n * i + j]);
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = i; j < m; j++) {
            int temp = matrix[n * i + j];
            matrix[n * i + j] = matrix[n * j + i];
            matrix[n * j + i] = temp;
        }
    }
    swap(&n, &m);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            printf("%d", matrix[n * i + j]);
        }
        printf("%s", "\n");
    }

    return 0;
}

// [1, 2, 3, 4, 5, 6]
// [1, 4, 2, 5, 3, 6]
// [[1, 2, 3],
//  [4, 5, 6]]
// [[1, 4],
//  [2, 5],
//  [3, 6]]