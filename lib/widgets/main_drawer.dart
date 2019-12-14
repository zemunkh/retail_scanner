import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:retail_scanner/screens/home_screen.dart';

import '../screens/printer_screen.dart';
import '../screens/dispatch_saved_screen.dart';
import '../screens/draft_screen.dart';
import '../screens/stock_saved_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, Function tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Documents',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 20,),
          buildListTile(
            'Home', 
            EvaIcons.home,
            () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
          ),
          buildListTile(
            'Stock Saved', 
            EvaIcons.checkmarkCircle,
            () {
              Navigator.of(context).pushReplacementNamed(StockSavedScreen.routeName);
            }
          ),
          buildListTile(
            'Dispatch Saved', 
            EvaIcons.carOutline,
            () {
              Navigator.of(context).pushReplacementNamed(DispatchSavedScreen.routeName);
            }
          ),          
          buildListTile(
            'Dispatch Draft', 
            EvaIcons.clock,
            () {
              Navigator.of(context).pushReplacementNamed(DraftScreen.routeName);
            }
          ),

          buildListTile(
            'Printer', 
            EvaIcons.printer,
            () {
              Navigator.of(context).pushReplacementNamed(PrinterScreen.routeName);
            }
          ),
        ],
      ),
    );
  }
}