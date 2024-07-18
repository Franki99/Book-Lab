import 'package:book_lab/components/my_list_tile.dart';
import 'package:book_lab/pages/add_editbook_page.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;
    final favoriteBooks = bookProvider.favoriteBooks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteBooks.isEmpty
          ? Center(
              child: Text(
                'No favorite books found',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.shade800
                        : Colours.midnightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MyListTile(
                    book: book,
                    onEditPressed: (context) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddEditBookPage(book: book),
                        ),
                      );
                    },
                    onDeletePressed: (context) {
                      bookProvider.deleteBook(book.id!);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class Colours {
  static const aquamarine = Color(0xFF7FFFD4);
  static const midnightBlue = Color(0xFF0D0D21);
  static const ggreen = Color(0xFF3247E5);
}
