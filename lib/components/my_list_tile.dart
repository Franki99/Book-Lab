import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String author;
  final double rating;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;

  const MyListTile({
    super.key,
    required this.title,
    required this.author,
    required this.rating,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

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
        title: Text(
          title,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author,
              style:
                  TextStyle(color: isDarkMode ? Colors.white70 : Colors.white),
            ),
            SizedBox(height: 4),
            RatingBarIndicator(
              rating: rating,
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
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: isDarkMode ? Colors.white : Colors.blue,
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
