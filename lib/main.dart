import 'package:flutter/material.dart';
import 'package:furniture_shop/constants.dart';
import 'package:furniture_shop/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Shop',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.dmSansTextTheme().apply(
          displayColor: kTextColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
