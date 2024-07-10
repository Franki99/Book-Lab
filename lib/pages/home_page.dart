import 'package:book_lab/components/my_list_tile.dart';
import 'package:book_lab/pages/add_editbook_page.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_lab/models/book.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:book_lab/providers/preference_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Lab'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Sort by Title') {
                preferencesProvider.setSortOrder('title');
              } else if (value == 'Sort by Author') {
                preferencesProvider.setSortOrder('author');
              } else if (value == 'Sort by Rating') {
                preferencesProvider.setSortOrder('rating');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Sort by Title',
                child: Text('Sort by Title'),
              ),
              PopupMenuItem(
                value: 'Sort by Author',
                child: Text('Sort by Author'),
              ),
              PopupMenuItem(
                value: 'Sort by Rating',
                child: Text('Sort by Rating'),
              ),
            ],
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, preferencesProvider, child) {
          return FutureBuilder<List<Book>>(
            future: bookProvider.fetchBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error fetching books'));
              }

              List<Book> books = snapshot.data ?? [];

              // Apply sorting based on preferencesProvider.sortOrder
              if (preferencesProvider.sortOrder == 'title') {
                books.sort((a, b) => a.title.compareTo(b.title));
              } else if (preferencesProvider.sortOrder == 'author') {
                books.sort((a, b) => a.author.compareTo(b.author));
              } else if (preferencesProvider.sortOrder == 'rating') {
                books.sort((a, b) => b.rating.compareTo(a.rating));
              }

              if (books.isEmpty) {
                return Center(child: Text('No books found'));
              }

              return Column(
                children: [
                  // Total books and sorting display
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Total books display
                        Text(
                          'Total Books: ${bookProvider.getTotalBooks()}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colours.aquamarine
                                : Colours.midnightBlue,
                          ),
                        ),

                        // Sorting display
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colours.ggreen : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            preferencesProvider.sortOrder.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey.shade800
                                : Colours
                                    .midnightBlue, // Adjust color as needed
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: MyListTile(
                            title: book.title,
                            author: book.author,
                            rating: book.rating
                                .toDouble(), // Cast int rating to double
                            onEditPressed: (context) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddEditBookPage(book: book),
                                ),
                              );
                            },
                            onDeletePressed: (context) async {
                              if (book.id != null) {
                                await bookProvider.deleteBook(
                                    book.id!); // Use the null-aware operator
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Book deleted')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Unable to delete book')),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode ? Colours.ggreen : Colors.red,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditBookPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  String _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

class Colours {
  static const aquamarine = Color(0xFF7FFFD4);
  static const midnightBlue = Color(0xFF0D0D21);
  static const ggreen = Color(0xFF3247E5);
}
