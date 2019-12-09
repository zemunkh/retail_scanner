import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/main_drawer.dart';
import '../widgets/saved_file_item.dart';

  _getFilesList() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'files_list';
    List<String> files = prefs.getStringList(key);
    print('Files List: $files');
    return files;
  }

class SavedScreen extends StatelessWidget {
  static const routeName = '/saved';

  // void _deleteTransaction(String id) {
  //   setState(() {
  //     _userTransactions.removeWhere((tx) =>  tx.id == id);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    // final fileData = Provider.of<Files>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Page'),
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
                    SavedFileItem(
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
    );
  }
}


// body: Padding(
//   padding: EdgeInsets.all(8),
//   child: ListView.builder(
//     itemCount: fileData.items.length,
//     itemBuilder: (_, i) => Column(
//           children: [
//             SavedFileItem(
//               fileData.items[i].id,
//               fileData.items[i].filename,
//               fileData.items[i].dir,
//             ),
//             Divider(),
//           ],
//         ),
//   ),
// ),