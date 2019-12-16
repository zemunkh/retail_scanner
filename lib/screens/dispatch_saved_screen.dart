import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/main_drawer.dart';
import '../widgets/dispatch_saved_file_item.dart';

_getFilesList() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'dispatch_files';
  List<String> files = prefs.getStringList(key);
  print('Dispatch Files List: $files');
  return files;
}

class DispatchSavedScreen extends StatefulWidget {
  static const routeName = '/dispatch_saved';

  @override
  _DispatchSavedScreenState createState() => _DispatchSavedScreenState();
}

class _DispatchSavedScreenState extends State<DispatchSavedScreen> {
  Future<bool> _backButtonPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit the Stock App?"),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // final fileData = Provider.of<Files>(context);
    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dispatch Saved Page'),
        ),
        drawer: MainDrawer(),
        body: Container(
          child: Center(
            child: new FutureBuilder(
              future: _getFilesList(),
              builder: (context, snapshot){
                var myData = snapshot.data;
                return ListView.builder(
                  itemCount: myData == null ? 0: myData.length,
                  itemBuilder: (_, i) => Column(
                    children: [
                      DispatchSavedFileItem(
                        myData[i],
                        i,
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ),
    );
  }
}

