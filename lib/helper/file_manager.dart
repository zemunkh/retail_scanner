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

    writeToJsonFile(productCode, 1, filename);

  }
}


Future<Null> _registerBarcode(String filename) async{
  Map<String, int> fileContent;

  dir = await getApplicationDocumentsDirectory();
  jsonRegisterFile = File("${dir.path}/$filename");
  jsonExists = jsonRegisterFile.existsSync();
  if(!jsonExists) {
    await jsonRegisterFile.create(recursive: true);
  } else {
    fileContent = json.decode(jsonRegisterFile.readAsStringSync());
  }
}

Future<Null> createFile(Map<String, int> content, Directory dir, String filename) async{
  print('Creating file...');
  dir = await getApplicationDocumentsDirectory();
  File file = new File("${dir.path}/$filename");
  file.createSync();
  jsonExists = true;
  file.writeAsStringSync(json.encode(content));
}

void writeToJsonFile(String key, int quantity, String filename) {
  print('Writing to file');
  Map<String, int> content = {key: quantity};
  if(jsonExists) {
    print('File does exist!');
    Map<String, int> jsonFileContent = json.decode(jsonRegisterFile.readAsStringSync());
    if(jsonFileContent[key] != null) {
      jsonFileContent[key] = jsonFileContent[key] + quantity;
    } else {
      jsonFileContent.addAll(content);
    }
    jsonRegisterFile.writeAsStringSync(json.encode(jsonFileContent));
  } else {
    print('File does not exist');
    createFile(content, dir, filename);
  }
  fileContent = json.decode(jsonRegisterFile.readAsStringSync());
  print('Json Data: $fileContent');
}