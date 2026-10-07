struct Book {
    id: i32,
    title: String,
    author: String,
    is_borrowed: bool,
}

struct Library {
    books: Vec<Book>,
}

impl Library {
    fn new() -> Self {
        Library { books: Vec::new() }
    }

    fn add_book(&mut self, id: i32, title: &str, author: &str) -> bool {
        self.books.push(Book {
            id,
            title: title.to_string(),
            author: author.to_string(),
            is_borrowed: false,
        });
        true
    }

    fn find_book_mut(&mut self, id: i32) -> Option<&mut Book> {
        self.books.iter_mut().find(|b| b.id == id)
    }

    fn borrow_book(&mut self, id: i32) -> bool {
        if let Some(book) = self.find_book_mut(id) {
            if !book.is_borrowed {
                book.is_borrowed = true;
                return true;
            }
        }
        false
    }

    fn return_book(&mut self, id: i32) -> bool {
        if let Some(book) = self.find_book_mut(id) {
            if book.is_borrowed {
                book.is_borrowed = false;
                return true;
            }
        }
        false
    }

    fn print(&self) {
        println!("Library contains {} books:", self.books.len());
        for book in &self.books {
            println!(
                "ID: {}, Title: {}, Author: {}, Borrowed: {}",
                book.id,
                book.title,
                book.author,
                if book.is_borrowed { "Yes" } else { "No" }
            );
        }
    }
}

fn main() {
    let mut lib = Library::new();

    lib.add_book(1, "The Rust Programming Language", "Steve Klabnik");
    lib.add_book(2, "The C Programming Language", "Brian Kernighan");

    lib.print();

    println!("Borrowing book 1: {}", if lib.borrow_book(1) { "Success" } else { "Failed" });
    println!("Borrowing book 1 again: {}", if lib.borrow_book(1) { "Success" } else { "Failed" });

    println!("Returning book 1: {}", if lib.return_book(1) { "Success" } else { "Failed" });
    println!("Returning book 1 again: {}", if lib.return_book(1) { "Success" } else { "Failed" });
}
