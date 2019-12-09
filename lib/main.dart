import 'package:flutter/material.dart';
import 'package:retail_scanner/screens/activation_screen.dart';
import 'package:retail_scanner/screens/printer_screen.dart';
import 'package:retail_scanner/screens/record_saved_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/draft_screen.dart';
import './screens/saved_screen.dart';
import './screens/home_screen.dart';
import './helper/file_manager.dart';

bool activated = false;

Future<void> main() async {
  try {
    await _read();
    runApp(MyApp());
  } catch(error) {
    print('Checking Activation Status');
  }
}

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
        '/': (ctx) => activated ? HomeScreen() : ActivationScreen(),
        '/main': (ctx) => HomeScreen(),
        DraftScreen.routeName: (ctx) => DraftScreen(),
        SavedScreen.routeName: (ctx) => SavedScreen(),
        RecordSavedScreen.routeName: (ctx) => RecordSavedScreen(),
        PrinterScreen.routeName: (ctx) => PrinterScreen(),
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

_read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_activation_status';
  final status = prefs.getBool(key) ?? false;
  print('Activation Status: $status');
  activated = status;
}