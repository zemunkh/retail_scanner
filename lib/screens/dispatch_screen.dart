import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';


class DispatchScreen extends StatelessWidget {
  static const routeName = '/dispatch';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Dispatch Page'),
      // ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Dispatch Note',
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