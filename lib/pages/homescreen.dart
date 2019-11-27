import 'package:flutter/material.dart';

import '../block/bottom_block.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../styles/theme.dart' as Style;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNavBarBlock _bottomNavBarBlock;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bottomNavBarBlock = BottomNavBarBlock();
  }

  @override
  void dispose() {
    _bottomNavBarBlock.close();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.background,
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            icon: Icon(
              EvaIcons.menu2Outline,
            ),
            color: Colors.black,
            onPressed: () {},
          ),
          title: new Text(
            "Stock Scan"
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                EvaIcons.infoOutline,
              ),
              color: Colors.black,
              onPressed: () {},
            )
          ],
        ),
      ),
      body: StreamBuilder<NavBarItem>(
        stream: _bottomNavBarBlock.itemStream,
        initialData: _bottomNavBarBlock.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data) {
            case NavBarItem.STOCKIN:
              return Center(child: Text('Hoho here'),);
              break;
            case NavBarItem.DISPATCHNOTE:
              return _dispatchNote();
              break;
            case NavBarItem.OTHERS:
              return _others();
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
                  'Stock In',
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
              BottomNavigationBarItem(
                title: Text(
                  'Others',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                icon: Icon(EvaIcons.layersOutline),
                activeIcon: Icon(EvaIcons.layers),
              ),                           
            ],
          );
        },
      ),
    );
  }

  Widget _dispatchNote() {
    return Center(
      child: Text(
        'Dispatch Note',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
  Widget _others() {
    return Center(
      child: Text(
        'Others Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.redAccent,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
