import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

_saveFilename(String key, String fname) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> files = prefs.getStringList(key);
  if(files == null || files.isEmpty) {
    files = [fname];
    prefs.setStringList(key, files);
  } else {
    if(files[files.length - 1] != fname) {
      files.add(fname);
      prefs.setStringList(key, files);
    }
  }
  print('Files List: $files');
}


class FileManager {
  static get context => null;

  static void saveDispatchData(String _createdAt, List<String> _valuesList) {

    writeToDispatchCsv(_createdAt, _valuesList).then((_){
      _saveFilename('dispatch_files', 'dispatch_$_createdAt.csv');
    });
  }

  static void saveScanData(String masterCode, String productCode, int counter, bool matched, DateTime currentDate) {
    String filename = '${DateFormat("yyyyMMdd").format(currentDate)}';
    String time = DateFormat("yyyy/MM/dd HH:mm:ss").format(currentDate);
    print('Time: $time');

    String matching = matched ? 'matched' : 'unmatched';

    writeToStockCsv(filename, time, masterCode, productCode, counter, matching).then((_){
      _saveFilename('stock_files', 'stock_$filename.csv');
    });
  }

  static Future<String> get _getLocalPath async {
    final directory  = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getCsvFile(String filename) async {
    final path = await _getLocalPath;
    print("$path/$filename.csv");

    File file = File("$path/$filename.csv");
    if(!await file.exists()) {
      print('Creating CSV file');
      file.createSync(recursive: true);

      return file;
    } else {
      print('Opening Existing CSV file');
      return file;
    }
  }

  static Future<Null> writeToStockCsv(String filename, String time, String key1, String key2, int counter, String matching) async {
    final file = await getCsvFile(filename);

    // String countedValue = await getCounter(filename, key);
    String newData = '$time, $key1, $key2, ${counter.toString()}, $matching \r\n';

    String content = file.readAsStringSync();
    file.writeAsStringSync(content + newData);
    print(content);
  }

  static Future<Null> writeToDispatchCsv(String createdAt, List<String> _valuesList) async {
    final file = await getCsvFile('$createdAt');
    String content = '';
    String newLine = '';
    for(int i = 0; i < _valuesList.length; i++){
      content = file.readAsStringSync();
      newLine = _valuesList[i];
      file.writeAsStringSync(content + newLine);
    }
    print(content);
  }

  static Future<Null> saveDraft(String key, List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, list);
  }


  static Future<List> readDraft(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> draftedList = prefs.getStringList(key);

    return draftedList;
  }

  static Future<Null> removeDraft(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }


  static Future<Null> saveProfile(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> readProfile(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String profile = prefs.getString(key);
    return profile;
  }

  static Future<Null> saveDraftList(String key, String draft_name) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> drafts = prefs.getStringList(key);
    if(drafts == null || drafts.isEmpty) {
      drafts = [draft_name];
      prefs.setStringList(key, drafts);
    } else {
      if(drafts[drafts.length - 1] != draft_name) {
        drafts.add(draft_name);
        prefs.setStringList(key, drafts);
      }
    }
    print('Files List: $drafts');
    return null;
  }

  static Future<List> getDraftList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> drafts = prefs.getStringList(key);
    if(drafts == null) {
      drafts = [];
    }
    print('Draft List: $drafts');
    return drafts;
  }
}
