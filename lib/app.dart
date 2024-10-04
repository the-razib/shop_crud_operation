import 'package:api/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class OnlineShop extends StatelessWidget {
  const OnlineShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: _buildInputDecorationTheme(),
        elevatedButtonTheme: buildElevatedButtonThemeData(),
        appBarTheme: buildAppBarTheme(),
        floatingActionButtonTheme: buildFloatingActionButtonThemeData()
      ),
      home: ProductListScreen(),
    );
  }

  FloatingActionButtonThemeData buildFloatingActionButtonThemeData() {
    return FloatingActionButtonThemeData(
        backgroundColor: Colors.green.shade200,
      );
  }

  AppBarTheme buildAppBarTheme() {
    return AppBarTheme(
        backgroundColor: Colors.green.shade600,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 24)
      );
  }

  ElevatedButtonThemeData buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size.fromWidth(double.maxFinite),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
        enabledBorder: _textFliedTheme(),
        errorBorder: _textFliedTheme(),
        focusedBorder: _textFliedTheme(),
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.black45, fontSize: 18));
  }

  OutlineInputBorder _textFliedTheme() {
    return OutlineInputBorder(
         borderRadius: BorderRadius.circular(8));
  }
}
