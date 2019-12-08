import 'package:flutter/foundation.dart';

class FileInfo with ChangeNotifier {
  final id;
  final String filename;
  final String dir;

  FileInfo({
    @required this.id,
    @required this.filename,
    @required this.dir,
  });
}