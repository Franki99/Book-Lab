import 'package:book_lab/models/book.dart';
import 'package:book_lab/pages/add_editbook_page.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AddEditBookPage(book: book)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              bookProvider.deleteBook(book.id!);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            Text('Rating: ${book.rating}', style: TextStyle(fontSize: 18)),
            Text('Read: ${book.read ? "Yes" : "No"}',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
