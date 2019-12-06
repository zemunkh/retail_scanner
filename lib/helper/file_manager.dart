import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';



class FileManager {
  static void saveScanData(String productCode, bool matched, DateTime currentDate) {
    String filename = '${DateFormat("yyyyMMdd").format(currentDate)}';
    String time = DateFormat("yyyy/MM/dd HH:mm:ss").format(currentDate);
    print('Time: $time');

    String matching = matched ? 'matched' : 'unmatched';

    writeJson(productCode, filename).then((_){
      writeToCsv(filename, time, productCode, matching);
    });

    // create csv and add logging data:
  }

  static Future<String> get _getLocalPath async {
    final directory  = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getJsonFile(String filename) async {
    final path = await _getLocalPath;
    File file = File("$path/$filename.json");
    if(!await file.exists()) {
      print('Creating new file');
      await file.create(recursive: true);
      Map<String, dynamic> content = {'Counter': 0, 'filename': filename};
      file.writeAsStringSync(json.encode(content));
      print('Json Data: $content');
      return file;
    } else {
      print('Opening existing file!');
      // file.deleteSync(recursive: true);
      return file;
    }
  }

  static Future<File> getCsvFile(String filename) async {
    final path = await _getLocalPath;
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

  static Future<Null> writeJson(String key, String filename) async {
    final file = await getJsonFile(filename);
    Map<String, dynamic> content = {key: 0, 'filename': filename};

    
    Map<String, dynamic> jsonFileContent = json.decode(file.readAsStringSync());

    if(jsonFileContent.isEmpty) {
      jsonFileContent.addAll(content);
    } else {
      if(jsonFileContent[key] == null) {
        jsonFileContent.addAll(content);
      } else {
        jsonFileContent[key] += 1;
      }
    }
 
    print('Json Data: $jsonFileContent');
    file.writeAsStringSync(json.encode(jsonFileContent));
  }

  static Future<String> getCounter(String filename, String key) async {
    try {
      final file = await getJsonFile(filename);
      Map<String, dynamic>  contents = json.decode(file.readAsStringSync());
      return contents[key].toString();
    } catch(e) {
      return "Error";
    }
  }

  static Future<Null> writeToCsv(String filename, String time, String key, String matching) async {
    final file = await getCsvFile(filename);
    
    String countedValue = await getCounter(filename, key);
    String newData = '$time, $key, $countedValue, $matching \r\n';

    String content = file.readAsStringSync();
    file.writeAsStringSync(content + newData);
    print(content);
  }
}
