import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

bool jsonExists = false;
File jsonRegisterFile;
Directory dir;
Map<String, int> fileContent;

class FileManager {
  static void saveScanData(String productCode, bool matched, DateTime currentDate) {
    String filename = '${DateFormat("yyyyMMdd").format(currentDate)}.json';
    String time = DateFormat("yyyy/MM/dd HH:mm:ss").format(currentDate);
    print('Time: $time');

    writeJson(productCode, 1, filename);

  }

  static Future<String> get _getLocalPath async {
    final directory  = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getFile(String filename) async {
    final path = await _getLocalPath;
    File jsonFile = File("$path/$filename");
    if(!await jsonFile.exists()) {
      return jsonFile;
    } else {
      jsonFile.createSync();
      return jsonFile;
    }
  }

  static Future<Null> writeJson(String key, int quantity, String filename) async {
    final file = await getFile(filename);
    Map<String, int> content = {key: quantity};

    
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

  static Future<String> readFromFile(String filename) async {
    try {
      final file = await getFile(filename);
      String contents = json.decode(file.readAsStringSync());
      return contents;
    } catch(e) {
      return "e";
    }
  }
}




// Future<Null> _registerBarcode(String filename) async{
//   Map<String, int> fileContent;

//   dir = await getApplicationDocumentsDirectory();
//   jsonRegisterFile = File("${dir.path}/$filename");
//   jsonExists = jsonRegisterFile.existsSync();
//   if(!jsonExists) {
//     await jsonRegisterFile.create(recursive: true);
//   } else {
//     fileContent = json.decode(jsonRegisterFile.readAsStringSync());
//   }
// }

// Future<Null> createFile(Map<String, int> content, Directory dir, String filename) async{
//   print('Creating file...');
//   dir = await getApplicationDocumentsDirectory();
//   File file = new File("${dir.path}/$filename");
//   file.createSync();
//   jsonExists = true;
//   file.writeAsStringSync(json.encode(content));
// }

// void writeToJsonFile(String key, int quantity, String filename) {
//   print('Writing to file');
//   Map<String, int> content = {key: quantity};
//   if(jsonExists) {
//     print('File does exist!');
//     Map<String, int> jsonFileContent = json.decode(jsonRegisterFile.readAsStringSync());
//     if(jsonFileContent[key] != null) {
//       jsonFileContent[key] = jsonFileContent[key] + quantity;
//     } else {
//       jsonFileContent.addAll(content);
//     }
//     jsonRegisterFile.writeAsStringSync(json.encode(jsonFileContent));
//   } else {
//     print('File does not exist');
//     createFile(content, dir, filename);
//   }
//   fileContent = json.decode(jsonRegisterFile.readAsStringSync());
//   print('Json Data: $fileContent');
// }