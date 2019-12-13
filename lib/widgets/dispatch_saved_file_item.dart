import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                _deleteFile(filename, index);
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


  _deleteFile(String filename, int index) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File currentFile = File("${dir.path}/$filename");

    final prefs = await SharedPreferences.getInstance();
    final key = 'dispatch_files';
    List<String> files = prefs.getStringList(key);
    if(prefs != null) {
      files.removeAt(index);
      prefs.setStringList(key, files);
      currentFile.deleteSync(recursive: true);
    }
    print('Files List: $files');
  }
}