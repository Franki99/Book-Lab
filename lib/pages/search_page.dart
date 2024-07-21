import 'package:book_lab/pages/add_editbook_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:book_lab/components/my_list_tile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
      Provider.of<BookProvider>(context, listen: false)
          .searchBooks(_searchQuery);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(12), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: isDarkMode ? Colors.black45 : Colors.grey.shade300,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search books, authors',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12), // Padding inside the box
              prefixIcon: _searchQuery.isEmpty
                  ? Icon(Icons.search,
                      size: 24,
                      color: isDarkMode ? Colors.white70 : Colors.black54)
                  : null,
              suffixIcon: _searchQuery.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.clear, size: 15),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                          bookProvider.searchBooks('');
                        },
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          final filteredBooks = bookProvider.filteredBooks;
          if (_searchQuery.isEmpty) {
            return Center(
              child: Text(
                'Search for something to find books',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white70 : Colours.midnightBlue,
                ),
              ),
            );
          }

          if (filteredBooks.isEmpty) {
            return Center(
              child: Text(
                'No books found',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white70 : Colours.midnightBlue,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredBooks.length,
            itemBuilder: (context, index) {
              final book = filteredBooks[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? Colors.grey.shade800 : Colours.midnightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyListTile(
                  book: book,
                  onEditPressed: (context) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: isDarkMode ? Colors.black : Colors.white,
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: DraggableScrollableSheet(
                            expand: false,
                            builder: (BuildContext context,
                                ScrollController scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.grey.shade900
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        AddEditBookPage(book: book),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  onDeletePressed: (context) async {
                    if (book.id != null) {
                      await bookProvider.deleteBook(book.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Book deleted')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Unable to delete book')),
                      );
                    }
                  },
                  // onToggleFavoritePressed: (context) async {
                  //   await bookProvider.toggleFavoriteStatus(book);
                  // },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Colors Used
class Colours {
  static const aquamarine = Color(0xFF7FFFD4);
  static const midnightBlue = Color(0xFF0D0D21);
  static const ggreen = Color(0xFF3247E5);
}
