import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_lab/models/book.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddEditBookPage extends StatefulWidget {
  final Book? book;

  AddEditBookPage({this.book});

  @override
  _AddEditBookPageState createState() => _AddEditBookPageState();
}

class _AddEditBookPageState extends State<AddEditBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  int _rating = 0;
  bool _isRead = false;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _rating = widget.book!.rating;
      _isRead = widget.book!.read;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newBook = Book(
        id: widget.book?.id,
        title: _titleController.text,
        author: _authorController.text,
        rating: _rating,
        read: _isRead,
      );

      if (widget.book == null) {
        Provider.of<BookProvider>(context, listen: false).addBook(newBook);
      } else {
        Provider.of<BookProvider>(context, listen: false).updateBook(newBook);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 50.0), // Move the box lower
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colours.midnightBlue
                    : Colors.black, // Set background color
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      style: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[100] : Colors.grey[100]),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    isDarkMode ? Colors.white : Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade600),
                          ),
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.white,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _authorController,
                      style: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[100] : Colors.grey[100]),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    isDarkMode ? Colors.white : Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade600),
                          ),
                          labelText: 'Author',
                          labelStyle: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.white,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an author';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Rating:',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white,
                          fontSize: 18),
                    ),
                    RatingBar.builder(
                      initialRating: _rating.toDouble(),
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      unratedColor:
                          isDarkMode ? Colors.white54 : Colors.grey[200],
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating.toInt();
                        });
                      },
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Read:',
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.white,
                              fontSize: 18),
                        ),
                        Switch(
                          value: _isRead,
                          onChanged: (value) {
                            setState(() {
                              _isRead = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: SizedBox(
                        width: 150, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: _saveForm,
                          style: ElevatedButton.styleFrom(
                            primary: isDarkMode
                                ? Colours.ggreen
                                : Colors.red, // Set the button color to red
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
