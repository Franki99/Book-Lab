import 'package:flutter/foundation.dart';
import 'package:book_lab/helper/db_helper.dart';
import 'package:book_lab/models/book.dart';

class BookProvider extends ChangeNotifier {
  final DBHelper dbHelper = DBHelper();
  List<Book> _books = [];
  List<Book> _filteredBooks = [];

  List<Book> get books => _books;
  List<Book> get filteredBooks => _filteredBooks;
  List<Book> get favoriteBooks =>
      _books.where((book) => book.isFavorite).toList();

  Future<List<Book>> fetchBooks() async {
    try {
      _books = await dbHelper.fetchBooks();
      _filteredBooks = _books;
      return _books;
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  int getTotalBooks() {
    return _books.length;
  }

  Future<void> addBook(Book book) async {
    try {
      await dbHelper.insertBook(book);
      await fetchBooks();
      notifyListeners();
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  Future<void> updateBook(Book book) async {
    try {
      await dbHelper.updateBook(book);
      int index = _books.indexWhere((b) => b.id == book.id);
      if (index != -1) {
        _books[index] = book;
        _filteredBooks = _books;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating book: $e');
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await dbHelper.deleteBook(id);
      _books.removeWhere((book) => book.id == id);
      _filteredBooks = _books;
      notifyListeners();
    } catch (e) {
      print('Error deleting book: $e');
    }
  }

  Future<void> toggleFavoriteStatus(Book book) async {
    book = Book(
      id: book.id,
      title: book.title,
      author: book.author,
      rating: book.rating,
      read: book.read,
      isFavorite: !book.isFavorite,
    );
    await updateBook(book);
  }

  void searchBooks(String query) {
    if (query.isEmpty) {
      _filteredBooks = _books;
    } else {
      _filteredBooks = _books
          .where((book) =>
              book.title.toLowerCase().contains(query.toLowerCase()) ||
              book.author.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
