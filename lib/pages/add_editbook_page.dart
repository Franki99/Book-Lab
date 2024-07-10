import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_lab/models/book.dart';
import 'package:book_lab/providers/book_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Ensure _formKey is correctly assigned here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 16),
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
                    Text('Rating:'),
                    DropdownButton<int>(
                      value: _rating,
                      onChanged: (newValue) {
                        setState(() {
                          _rating = newValue!;
                        });
                      },
                      items: List.generate(
                          6,
                          (index) => DropdownMenuItem(
                                child: Text(index.toString()),
                                value: index,
                              )),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Read:'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
