import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/main_drawer.dart';
import '../widgets/stock_saved_file_item.dart';

  _getFilesList() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'stock_files';
    List<String> files = prefs.getStringList(key);
    print('Stock Files List: $files');
    return files;
  }

class StockSavedScreen extends StatefulWidget {
  static const routeName = '/stock_saved';

  @override
  _StockSavedScreenState createState() => _StockSavedScreenState();
}

class _StockSavedScreenState extends State<StockSavedScreen> {
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
          title: Text('Stock Saved Page'),
        ),
        drawer: MainDrawer(),
        body: Container(
          child: new FutureBuilder(
            future: _getFilesList(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                var myData = snapshot.data;
                return Container(
                  child: ListView.builder(
                    itemCount: myData == null ? 0: myData.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        SavedFileItem(
                          myData[i],
                          i,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              }
              else {
                return new Center(child:CircularProgressIndicator(),);
              }
            },
          ),
        ),
      ),
    );
  }
}
