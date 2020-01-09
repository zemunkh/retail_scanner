import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retail_scanner/helper/file_manager.dart';
import 'package:share_extend/share_extend.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:retail_scanner/screens/dispatch_saved_screen.dart';


class DispatchSavedFileItem extends StatelessWidget {
  final String filename;
  final int index;

  DispatchSavedFileItem(this.filename, this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(filename),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(EvaIcons.share),
              onPressed: () {
                print('I am tapped on $index');
                _shareApplicationDocumentsFile(filename);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(EvaIcons.trash2Outline),
              onPressed: () {
                FileManager.deleteFile(filename, index, 'dispatch_files');
                Navigator.of(context).pushReplacementNamed(DispatchSavedScreen.routeName);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }


  _shareApplicationDocumentsFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = File("${dir.path}/$filename");
    if (!await testFile.exists()) {
      print('File not existed');
    }
    ShareExtend.share(testFile.path, "file");
  }

}