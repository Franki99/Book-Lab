import 'package:book_lab/models/book.dart';
import 'package:book_lab/pages/add_editbook_page.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    // final preferencesProvider = Provider.of<PreferencesProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Edit and Delete icons in separate boxes with text
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colours.ggreen : Colors.lightBlue,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                              isDarkMode ? Colors.grey.shade800 : Colors.white,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.red : Colors.red,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        bookProvider.deleteBook(book.id!);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Book details in a box
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colours.midnightBlue,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${book.title}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? Colours.aquamarine
                            : Colours.aquamarine,
                      )),
                  SizedBox(height: 8.0),
                  Text('Author: ${book.author}',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(height: 8.0),
                  Text('Rating:',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(height: 4.0),
                  RatingBar.builder(
                    initialRating: book.rating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    unratedColor: isDarkMode ? Colors.white54 : Colors.white,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(height: 8.0),
                  Text('Read: ${book.read ? "Yes" : "No"}',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Colours {
  static const aquamarine = Color(0xFF7FFFD4);
  static const midnightBlue = Color(0xFF0D0D21);
  static const ggreen = Color(0xFF3247E5);
}
