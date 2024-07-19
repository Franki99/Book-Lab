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
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.book == null ? 'Add Book' : 'Edit Book',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colours.aquamarine : Colours.midnightBlue,
            ),
          ),
          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an author';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rating:',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.white,
                          fontSize: 18),
                    ),
                    RatingBar.builder(
                      initialRating: _rating.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating.toInt();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mark as Read',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? Colours.aquamarine
                            : Colours.midnightBlue,
                      ),
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
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: SizedBox(
                    width: 150,
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
        ],
      ),
    );
  }
}

class Colours {
  static const aquamarine = Color(0xFF7FFFD4);
  static const midnightBlue = Color(0xFF0D0D21);
  static const ggreen = Color(0xFF3247E5);
}
