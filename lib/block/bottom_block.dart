import 'dart:async';

enum NavBarItem { STOCKIN, DISPATCHNOTE }


class BottomNavBarBlock {
  final StreamController<NavBarItem> _navBarController = StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.STOCKIN;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.STOCKIN);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.DISPATCHNOTE);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}