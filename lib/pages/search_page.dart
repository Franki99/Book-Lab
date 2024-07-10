import 'package:book_lab/pages/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_lab/models/book.dart';
import 'package:book_lab/providers/book_provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                bookProvider.searchBooks(query);
              },
            ),
          ),
          Expanded(
            child: Consumer<BookProvider>(
              builder: (context, provider, child) {
                List<Book> books = provider.books;

                if (books.isEmpty) {
                  return Center(child: Text('No books found'));
                }

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(book: book),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
