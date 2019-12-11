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

  @override
  Widget build(BuildContext context) {
    // final fileData = Provider.of<Files>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Page'),
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
              return new CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
