import 'package:flutter/foundation.dart';
import 'package:book_lab/helper/db_helper.dart';
import 'package:book_lab/models/book.dart';

class BookProvider extends ChangeNotifier {
  final DBHelper dbHelper = DBHelper();
  List<Book> _books = [];

  List<Book> get books => _books;

  Future<List<Book>> fetchBooks() async {
    try {
      _books = await dbHelper.fetchBooks();
      return _books;
    } catch (e) {
      print('Error fetching books: $e');
      // Handle error as needed
      return []; // Return empty list or throw an error based on your logic
    }
  }

  int getTotalBooks() {
    return _books.length;
  }

  Future<void> addBook(Book book) async {
    try {
      await dbHelper.insertBook(book);
      await fetchBooks(); // Refresh the list after adding a book
      notifyListeners();
    } catch (e) {
      print('Error adding book: $e');
      // Handle error as needed
    }
  }

  Future<void> updateBook(Book book) async {
    try {
      await dbHelper.updateBook(book);
      await fetchBooks(); // Refresh the list after updating a book
      notifyListeners();
    } catch (e) {
      print('Error updating book: $e');
      // Handle error as needed
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await dbHelper.deleteBook(id);
      await fetchBooks(); // Refresh the list after deleting a book
      notifyListeners();
    } catch (e) {
      print('Error deleting book: $e');
      // Handle error as needed
    }
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      // Reset to original list if query is empty
      fetchBooks();
    } else {
      _books = _books.where((book) {
        // Customize this condition based on your search requirements
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase());
      }).toList();
      notifyListeners();
    }
  }
}
