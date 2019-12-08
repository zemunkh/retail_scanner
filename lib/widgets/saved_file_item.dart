import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import '../providers/files.dart';

class SavedFileItem extends StatelessWidget {
  final String id;
  final String filename;
  final String dir;

  SavedFileItem(this.id, this.filename, this.dir);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(id),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                print('I am tapped');
                _shareApplicationDocumentsFile(filename);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Provider.of<Files>(context, listen: false).deleteProduct(id);
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