import 'package:flutter/material.dart';
import 'package:retail_scanner/screens/activation_screen.dart';
import './screens/draft_screen.dart';
import './screens/saved_screen.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mugs Stock Control',
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
      // home: HomeScreen(),
      routes: {
        '/': (ctx) => ActivationScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        DraftScreen.routeName: (ctx) => DraftScreen(),
        SavedScreen.routeName: (ctx) => SavedScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        );
      },
    );
  }
}