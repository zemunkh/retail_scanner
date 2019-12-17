import 'package:flutter/material.dart';
import 'package:retail_scanner/model/dispatch_arguments.dart';
import 'package:retail_scanner/screens/dispatch_draft_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DispatchDraftItem extends StatelessWidget {
  final String draftName;
  final int index;

  DispatchDraftItem(this.draftName, this.index);

  List<String> _masterList = [];
  List<String> _productList = [];
  List<String> _counterList = [];  // Matched Counter Value
  List<String> _otherList = [];

  Future<Null> loadData() {
    List<String> header = ['draft_master_$index', 'draft_product_$index', 'draft_counter_$index', 'draft_other_$index'];

    

  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(draftName),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(EvaIcons.trash2Outline),
              onPressed: () {
                _deleteDraft(draftName, index);
                Navigator.of(context).pushReplacementNamed(DispatchDraftScreen.routeName);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
      onTap: (){
        print('Tapped, Move to next screen');
        // Navigator.of(context).pushReplacementNamed(DispatchDraftScreen.routeName,
        //   arguments: DraftScreenArguments('Some Draft', index),
        // );
      },
    );
  }

  _deleteDraft(String draftName, int index) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'draft_list';
    List<String> files = prefs.getStringList(key);
    if(prefs != null) {
      files.removeAt(index);
      prefs.setStringList(key, files);
    }
    print('Files List: $files');
  }
}