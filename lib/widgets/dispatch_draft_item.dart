import 'package:flutter/material.dart';
import 'package:retail_scanner/helper/file_manager.dart';
import 'package:retail_scanner/screens/dispatch_draft_edit_screen.dart';
import 'package:retail_scanner/screens/dispatch_draft_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DispatchDraftItem extends StatelessWidget {
  final String draftName;
  final int index;

  DispatchDraftItem(this.draftName, this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold),),
      title: Text(draftName),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(EvaIcons.trash2Outline),
              onPressed: () {
                FileManager.removeFromBank(index);
                print('Draft name: $draftName');
                Navigator.of(context).pushReplacementNamed(DispatchDraftScreen.routeName);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
      onTap: (){
        print('Tapped, Move to next screen');
        print('Draft name: $draftName');
        FileManager.setSelectedIndex(index);

        Navigator.of(context).pushReplacementNamed(DispatchDraftEditScreen.routeName);
      },
    );
  }
}