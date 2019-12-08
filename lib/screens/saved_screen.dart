import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/files.dart';
import '../widgets/main_drawer.dart';
import '../widgets/saved_file_item.dart';

class SavedScreen extends StatelessWidget {
  static const routeName = '/saved';
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
            future: DefaultAssetBundle.of(context).loadString('assets/data/files.json'),
            builder: (context, snapshot){
              var myData = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemCount: myData == null ? 0: myData.length,
                itemBuilder: (_, i) => Column(
                      children: [
                        SavedFileItem(
                          myData[i]['id'],
                          myData[i]['filename'],
                          myData[i]['dir'],
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