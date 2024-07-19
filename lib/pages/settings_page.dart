import 'package:book_lab/pages/about_page.dart';
import 'package:book_lab/pages/contact_page.dart';
import 'package:book_lab/pages/help_page.dart';
import 'package:book_lab/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            child: ListTile(
              // leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              title: Text('Change Theme'),
              trailing: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onTap: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.assistant),
                  title: Text('Help'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpPage()),
                    );
                  },
                ),
                Divider(
                  height: 1,
                  color:
                      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
                ),
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Tell a friend'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                Divider(
                  height: 1,
                  color:
                      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail),
                  title: Text('Contact Us'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Card(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('App Version'),
              subtitle: Text(
                '1.0.0',
                style: TextStyle(
                    color: isDarkMode ? Colours.aquamarine : Colors.red,
                    fontWeight: FontWeight.bold),
              ), // Replace with your actual app version
            ),
          ),
        ],
      ),
    );
  }
}

class FontSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Font Style'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Default'),
            onTap: () {
              // themeProvider.setFontStyle(null);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Serif'),
            onTap: () {
              // themeProvider.setFontStyle('Serif');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Monospace'),
            onTap: () {
              // themeProvider.setFontStyle('Monospace');
              Navigator.pop(context);
            },
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
