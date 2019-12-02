import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';


class DraftScreen extends StatelessWidget {
  static const routeName = '/drafts';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draft Page'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Hello Zee'),
      ),
    );
  }
}