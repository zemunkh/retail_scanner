import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

_saveFilename(String key, String fname) async {
  final prefs = await SharedPreferences.getInstance();
  final filename = fname;
  List<String> files = prefs.getStringList(key);
  if(files == null || files.isEmpty) {
    files = [filename];
    prefs.setStringList(key, files);
  } else {
    if(files[files.length - 1] != filename) {
      files.add(filename);
      prefs.setStringList(key, files);
    }
  }
  
  print('Files List: $files');
}


class FileManager {
  static get context => null;

  static void saveDispatchData(String createdAt, String dispatchNum, String totalItem, String masterCode, String productCode, String mCounter, String completedDate) {
    writeToDispatchCsv(createdAt, dispatchNum, totalItem, masterCode, productCode, mCounter, completedDate).then((_){
      _saveFilename('dispatch_files', '$createdAt.csv');
    });
  }

  static void saveScanData(String masterCode, String productCode, int counter, bool matched, DateTime currentDate) {
    String filename = '${DateFormat("yyyyMMdd").format(currentDate)}';
    String time = DateFormat("yyyy/MM/dd HH:mm:ss").format(currentDate);
    print('Time: $time');

    String matching = matched ? 'matched' : 'unmatched';

    writeToStockCsv(filename, time, masterCode, productCode, counter, matching).then((_){
      _saveFilename('stock_files', '$filename.csv');
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

  static Future<Null> writeToDispatchCsv(String createdAt, String dispatchNum, String totalItem, String masterCode, String productCode, String mCounter, String completedDate) async {
    final file = await getCsvFile('$createdAt.csv');
    String newData = '$createdAt, $dispatchNum, $totalItem, $masterCode, $productCode, $mCounter, $completedDate';

    String content = file.readAsStringSync();
    file.writeAsStringSync(content + newData);
    print(content);
  }
}
