import 'package:flutter/material.dart';
import 'package:galaxy_planets/models/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeModel themeModel;
//
//   ThemeProvider({required this.themeModel});
//
//   changeTheme() async {
//     themeModel.isDark = !themeModel.isDark;
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     prefs.setBool('isDark', themeModel.isDark);
//
//     notifyListeners();
//   }
// }
class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel;

  ThemeProvider({required this.themeModel});

  changeTheme() async {
    themeModel.isDark = !themeModel.isDark;

    SharedPreferences Pref = await SharedPreferences.getInstance();

    Pref.setBool("isDark", themeModel.isDark);

    notifyListeners();
  }

  changeNotification() async {
    themeModel.notification = !themeModel.notification;
    SharedPreferences Pref = await SharedPreferences.getInstance();

    Pref.setBool("isNotification", themeModel.notification);

    notifyListeners();
  }
}
