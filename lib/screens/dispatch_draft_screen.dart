import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retail_scanner/helper/file_manager.dart';
import 'package:retail_scanner/widgets/dispatch_draft_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/print_note.dart';
import '../widgets/main_drawer.dart';


_getDraftList() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'draft_bank';
  List<String> drafts = prefs.getStringList(key);
  print('Draft Bank: $drafts');
  return drafts;
}

class DispatchDraftScreen extends StatefulWidget {
  static const routeName = '/drafts';
  @override
  DispatchDraftScreenState createState() => DispatchDraftScreenState();
}

class DispatchDraftScreenState extends State<DispatchDraftScreen> {
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
          title: Text('Dispatch Draft List'),
        ),
        drawer: MainDrawer(),
        body: Container(
          child: new FutureBuilder(
            future: _getDraftList(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                var myData = snapshot.data;
                return Container(
                  child: ListView.builder(
                    itemCount: myData == null ? 0: myData.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        DispatchDraftItem(
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


_setNumberItems(int val) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'number_items';
  prefs.setInt(key, val);
  print('Items set to $val');
}
