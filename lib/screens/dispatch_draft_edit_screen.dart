import 'package:flutter/material.dart';

class DispatchDraftEditScreen extends StatefulWidget {
  static const routeName = '/draft_edit';
  @override
  DispatchDraftEditScreenState createState() => DispatchDraftEditScreenState();
}

class DispatchDraftEditScreenState extends State<DispatchDraftEditScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draft Edit Page'),
      ),
      body: Container(
        child: Text('Hello Zee!'),
      ),
    );
  }
}