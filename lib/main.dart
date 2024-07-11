import 'package:book_lab/pages/home_page.dart';
import 'package:book_lab/pages/search_page.dart';
import 'package:book_lab/pages/favorites_page.dart';
import 'package:book_lab/pages/settings_page.dart';
import 'package:book_lab/providers/book_provider.dart';
import 'package:book_lab/providers/preference_provider.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => PreferencesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          home: BottomNavBar(),
        );
      },
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        color: isDarkMode ? Colors.black : Colors.transparent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                // Adjust width and height for the main navigation box
                width: 265.0,
                height: 52.0,
                margin: EdgeInsets.only(left: 16.0, right: 80.0, bottom: 6.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colours.ggreen : Colours.midnightBlue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Create navigation items
                    _buildNavItem(
                      icon: Icons.library_books,
                      index: 0,
                      label: 'Library',
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.search,
                      index: 1,
                      label: 'Search',
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.favorite,
                      index: 2,
                      label: 'Favorites',
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
            // Positioned FloatingActionButton for settings
            Positioned(
              right: 16.0,
              bottom: 5.0,
              child: Container(
                // Adjust the size of the container to increase the height
                height: 55.0, // Adjusted height
                width: 55.0, // Adjusted width
                child: FloatingActionButton(
                  backgroundColor:
                      isDarkMode ? Colours.ggreen : Colours.midnightBlue,
                  onPressed: () => _onItemTapped(3),
                  child: Icon(
                    Icons.settings,
                    color: _selectedIndex == 3
                        ? isDarkMode
                            ? Colors.black
                            : Colors.amber[800]
                        : isDarkMode
                            ? Colors.white
                            : Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required String label,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        // Highlight selected tab
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? isDarkMode
                  ? Colors.white
                  : Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: _selectedIndex == index
                  ? isDarkMode
                      ? Colors.black
                      : Colors.black
                  : isDarkMode
                      ? Colors.white
                      : Colors.white,
            ),
            // Display label only if the tab is selected
            if (_selectedIndex == index)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isDarkMode ? Colors.black : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
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
