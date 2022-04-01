#include <stdio.h>
#include <stdlib.h>

struct Entry {
    int data;
    struct Entry* next;
};

void reverse(struct Entry** head) {
    struct Entry* prev = NULL;
    struct Entry* cur = *head;
    struct Entry* next = NULL;
    while (cur != NULL) {
        next = cur->next;
        cur->next = prev;
        prev = cur;
        cur = next;
    }
    *head = prev;
}

void printList(struct Entry* head) {
    struct Entry* temp = head;
    while (temp != NULL) {
        printf("%d ", temp->data);
        temp = temp->next;
    }
}

int main() {
    struct Entry* head = (struct Entry*)malloc(sizeof(struct Entry));
    int x;
    scanf("%d", &x);
    head->data = x;
    scanf("%d", &x);
    struct Entry* cur = (struct Entry*)malloc(sizeof(struct Entry));
    cur->data = x;
    head->next = cur;

    while (1) {
        scanf("%d", &x);
        if (x == 0) {
            break;
        }
        struct Entry* cur1 = (struct Entry*)malloc(sizeof(struct Entry));
        cur1->data = x;
        cur->next = cur1;
        cur = cur1;
    }

    printList(head);
    printf("%s", "\n");
    reverse(&head);
    printList(head);

    return 0;
}