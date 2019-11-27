import 'package:flutter/material.dart';
import './pages/homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retail Scanner',
      theme: ThemeData(
        accentColor: Colors.amber,
        primarySwatch: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        fontFamily: 'HelveticaNeue',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}