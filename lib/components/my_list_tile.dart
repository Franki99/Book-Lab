import 'package:book_lab/providers/book_provider.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:book_lab/models/book.dart';
import 'package:book_lab/pages/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyListTile extends StatelessWidget {
  final Book book;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;

  const MyListTile({
    super.key,
    required this.book,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // Edit option
          SlidableAction(
            onPressed: onEditPressed,
            icon: Icons.settings,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          // Delete option
          SlidableAction(
            onPressed: onDeletePressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookDetailPage(book: book),
              ),
            );
          },
          child: Text(
            book.title,
            style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.author,
              style:
                  TextStyle(color: isDarkMode ? Colors.white70 : Colors.white),
            ),
            SizedBox(height: 4),
            RatingBarIndicator(
              rating: book.rating.toDouble(),
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
              unratedColor: isDarkMode ? Colors.white54 : Colors.white,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                book.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: book.isFavorite
                    ? Colors.red
                    : (isDarkMode ? Colors.white54 : Colors.white),
              ),
              onPressed: () {
                bookProvider.toggleFavoriteStatus(book);
              },
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: isDarkMode ? Colors.white : Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
