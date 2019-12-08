import 'package:flutter/material.dart';
import './file_info.dart';

class Files with ChangeNotifier {
  List<FileInfo> _items = [
    FileInfo(
      id: 'p1',
      filename: '20191209.csv',
      dir: '/20191209.csv',
    ),
  ];

  List<FileInfo> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  void addProduct(FileInfo file) {
    final newFile = FileInfo(
      filename: file.filename,
      dir: file.dir,
      id: DateTime.now().toString(),
    );
    _items.add(newFile);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}