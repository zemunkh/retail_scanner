import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';


class SavedScreen extends StatelessWidget {
  static const routeName = '/saved';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Page'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Hello Zee'),
      ),
    );
  }
}