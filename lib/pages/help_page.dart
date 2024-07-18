import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Help & FAQ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'How to add a book?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'To add a book, click on the "Add" button on the main screen. Fill in the book details and click "Save".',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'How to edit a book?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'To edit a book, swipe the book entry to the left and click on the "Edit" icon. Modify the details and click "Save".',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'How to delete a book?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'To delete a book, swipe the book entry to the left and click on the "Delete" icon. Confirm the deletion.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'How to mark a book as read or unread?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'To mark a book as read or unread, click on the book entry and toggle the "Read" status.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'How to mark a book as favorite?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'To mark a book as favorite, click on the heart icon on the book entry. Click again to unmark as favorite.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'For more assistance, contact our support team at support@example.com.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
