#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#define MAX_BOOKS 100

typedef struct {
    int id;
    char title[100];
    char author[50];
    bool is_borrowed;
} Book;

typedef struct {
    Book books[MAX_BOOKS];
    int count;
} Library;

void init_library(Library* lib) {
    lib->count = 0;
}

int add_book(Library* lib, int id, const char* title, const char* author) {
    if (lib->count >= MAX_BOOKS) return 0;
    
    Book* b = &lib->books[lib->count];
    b->id = id;
    strncpy(b->title, title, sizeof(b->title) - 1);
    b->title[sizeof(b->title) - 1] = '\0';
    strncpy(b->author, author, sizeof(b->author) - 1);
    b->author[sizeof(b->author) - 1] = '\0';
    b->is_borrowed = false;
    
    lib->count++;
    return 1; 
}

Book* find_book(Library* lib, int id) {
    for (int i = 0; i < lib->count; i++) {
        if (lib->books[i].id == id) return &lib->books[i];
    }
    return NULL;
}

bool borrow_book(Library* lib, int id) {
    Book* book = find_book(lib, id);
    if (book && !book->is_borrowed) {
        book->is_borrowed = true;
        return true;
    }
    return false;
}

bool return_book(Library* lib, int id) {
    Book* book = find_book(lib, id);
    if (book && book->is_borrowed) {
        book->is_borrowed = false;
        return true;
    }
    return false;
}

void print_library(const Library* lib) {
    printf("Library contains %d books:\n", lib->count);
    for (int i = 0; i < lib->count; i++) {
        printf("ID: %d, Title: %s, Author: %s, Borrowed: %s\n",
               lib->books[i].id,
               lib->books[i].title,
               lib->books[i].author,
               lib->books[i].is_borrowed ? "Yes" : "No");
    }
}

int main() {
    Library lib;
    init_library(&lib);

    add_book(&lib, 1, "The Rust Programming Language", "Steve Klabnik");
    add_book(&lib, 2, "The C Programming Language", "Brian Kernighan");

    print_library(&lib);

    printf("Borrowing book 1: %s\n", borrow_book(&lib, 1) ? "Success" : "Failed");
    printf("Borrowing book 1 again: %s\n", borrow_book(&lib, 1) ? "Success" : "Failed");

    printf("Returning book 1: %s\n", return_book(&lib, 1) ? "Success" : "Failed");
    printf("Returning book 1 again: %s\n", return_book(&lib, 1) ? "Success" : "Failed");

    return 0;
}
