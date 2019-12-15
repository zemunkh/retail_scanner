import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/main_drawer.dart';
import '../block/bottom_block.dart';
import '../widgets/stock_check.dart';
import '../widgets/dispatch_note.dart';

import '../styles/theme.dart' as Style;


class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNavBarBlock _bottomNavBarBlock;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  NavBarItem dd;
  // NavBarItem _userSelectedNavBar = _bottomNavBarBlock.firstItem;

  @override
  void initState() {
    super.initState();
    initNavBar();
  }

  initNavBar() async {
    _bottomNavBarBlock = BottomNavBarBlock();
    bool isStockPage = await _getNavBarItem();
    if(isStockPage) {
      print('Stock is enabled');
      // dd = NavBarItem.STOCKIN;
      _bottomNavBarBlock.pickItem(0);
    } else {
      // dd = NavBarItem.DISPATCHNOTE;
      _bottomNavBarBlock.pickItem(1);
      print('Stock is disabled');
    }
  }

  @override
  void dispose() {
    _bottomNavBarBlock.close();
    super.dispose();
  }

  Future<bool> _backButtonPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit the Stock App?"),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      )
    );
  }

  @override 
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: Scaffold(
        backgroundColor: Style.Colors.background,
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            backgroundColor: Colors.redAccent,
            leading: IconButton(
              icon: Icon(
                EvaIcons.menu2Outline,
              ),
              color: Colors.white,
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            title: new Text(
              'Mugs Stock Control',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  EvaIcons.infoOutline,
                ),
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBlock.itemStream,
          initialData: _bottomNavBarBlock.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.STOCKIN:
                return StockIn(); 
                break;
              case NavBarItem.DISPATCHNOTE:
                return DispatchNote();
                break;
              default:
                return null;
            }
          },
        ),
        bottomNavigationBar: StreamBuilder(
          stream: _bottomNavBarBlock.itemStream,
          initialData: _bottomNavBarBlock.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            return BottomNavigationBar(
              elevation: 10,
              unselectedFontSize: 8,
              selectedFontSize: 12,
              fixedColor: Style.Colors.mainColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: snapshot.data.index,
              onTap: _bottomNavBarBlock.pickItem,
              items: [
                BottomNavigationBarItem(
                  title: Text(
                    'Stock Check',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  icon: Icon(EvaIcons.checkmarkCircle),
                  activeIcon: Icon(EvaIcons.checkmarkCircleOutline),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    'Dispatch Note',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  icon: Icon(EvaIcons.carOutline),
                  activeIcon: Icon(EvaIcons.car),
                ),                          
              ],
            );
          },
        ),
      ),
    );
  }
}


_getNavBarItem() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'main_navbar_stock';
  bool val = prefs.getBool(key);
  print('NavBar Stock is enabled: $val');
  return val;
}