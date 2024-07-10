import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider with ChangeNotifier {
  SharedPreferences? _prefs;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String _sortOrder = 'title';
  String get sortOrder => _sortOrder;

  PreferencesProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs?.getBool('isDarkMode') ?? false;
    _sortOrder = _prefs?.getString('sortOrder') ?? 'title';
    notifyListeners();
  }

  // Future<void> toggleTheme() async {
  //   _isDarkMode = !_isDarkMode;
  //   await _prefs?.setBool('isDarkMode', _isDarkMode);
  //   notifyListeners();
  // }

  Future<void> setSortOrder(String order) async {
    _sortOrder = order;
    await _prefs?.setString('sortOrder', _sortOrder);
    notifyListeners();
  }
}
