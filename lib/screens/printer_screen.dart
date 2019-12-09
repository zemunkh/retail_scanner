import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';


class PrinterScreen extends StatelessWidget {
  static const routeName = '/printer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printer Page'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Others',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.blue,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}