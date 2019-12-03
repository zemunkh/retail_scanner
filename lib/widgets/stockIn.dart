import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import './noediting.dart';
import 'package:flutter/services.dart';
// import './rawkeyboard.dart';


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class StockIn extends StatefulWidget {
  @override
  StockInState createState() => StockInState();
}

class StockInState extends State<StockIn> {
  final _masterController = TextEditingController();
  final _productController = TextEditingController();

  final FocusNode _masterNode = FocusNode();
  final FocusNode _productNode = FocusNode();

  bool matched = false;
  bool oneToMany = false;
  var counter = 0;

  void _compareData() {
    final masterCode = _masterController.text;
    final productCode = _productController.text;

    print('Comparison: $masterCode : $productCode');

    if(masterCode == productCode) {
      setState(() {
        matched = true;
        counter++;
        if(oneToMany) {
          _productController.clear();
        } else {
          // _masterController.clear();
          // _productController.clear();
        }
      });
    } else {
      setState(() {
        matched = false;
      });
    }
  }


  void _enableOneToMany(bool isOn) {
    setState(() {
      oneToMany = isOn;
      isOn = !isOn;
      _masterController.clear();
      _productController.clear();
      counter = 0; 
    });
    print('Switch button value $oneToMany');
  }
  String buffer = '';

  masterListener() {
    print('Current text: ${_masterController.text}');
    buffer = _masterController.text;
    if(buffer.endsWith('\\n')){
      // _masterController.text = buffer.trim();
      buffer = buffer.substring(0, buffer.length - 2);
      print('Master text: $buffer');
      setState(() {
        _masterController.text = buffer;
      });

      _masterNode.unfocus();
      FocusScope.of(context).requestFocus(_productNode);
    }
  }

  productListener() async {
    buffer = _productController.text;
    if(buffer.endsWith('\\n')) {
      buffer = buffer.substring(0, buffer.length - 2);
      print('Master text: $buffer');
      setState(() {
        _productController.text = buffer;
      });

      _compareData();
      if(oneToMany) {
        FocusScope.of(context).requestFocus(_productNode);
      } else {
        _productNode.unfocus();
        FocusScope.of(context).requestFocus(new FocusNode());
      }

    }
  }
    
  @override
  void dispose() {
    super.dispose();
    _masterController.dispose();
    _productController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _masterController.addListener(masterListener);
    _productController.addListener(productListener);
  }
  
  @override
  Widget build(BuildContext context) {
    // To hide keyboards on the restart.
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Master',
                style: TextStyle(
                  color: Colors.grey[700], 
                  fontSize: 32,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                Container(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 22, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF004B83),
                      hintText: 'Master key',
                      hintStyle: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    autofocus: true,
                    controller: _masterController,
                    focusNode: _masterNode,
                    onTap: () { FocusScope.of(context).requestFocus(_masterNode); },
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _masterController.clear();
                  },
                  child: Icon(EvaIcons.refresh, color: Colors.white, size: 30,),
                ),
              ],
            ),

            SizedBox(height: 30, 
              // child: ScanKeyboard(),
            ),

            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: matched? new Icon(
                      EvaIcons.checkmarkCircleOutline,
                      size: 100,
                      color: Colors.green,
                    ) : new Icon(
                      EvaIcons.closeCircleOutline,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 80),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10),
                      ),
                      side: BorderSide(width: 1, color: Colors.black), 
                    ),
                  ),
                  child: Center(
                    child: Text(
                      counter.toString(),
                      style: TextStyle(
                        fontSize: 80,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Product',
                style: TextStyle(
                  color: Colors.grey[700], 
                  fontSize: 32,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                  TextFormField(
                  style: TextStyle(
                    fontSize: 22, 
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF004B83),
                    hintText: 'Product key',
                    hintStyle: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  // autofocus: true,
                  controller: _productController,
                  focusNode: _productNode,
                  onTap: () { FocusScope.of(context).requestFocus(_productNode); },
                ),
                FlatButton(
                  onPressed: () {
                    _productController.clear();
                  },
                  child: Icon(EvaIcons.refresh, color: Colors.white, size: 30,),
                ),
              ],
            ),          
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: 2.0,
                      child: Switch(
                        value: oneToMany,
                        activeColor: Colors.blueAccent,
                        onChanged: (isOn) {
                          _enableOneToMany(isOn);
                        },
                      ),
                    ),
                    Center(
                      child: Text('One to Many'),
                    ),
                  ],
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'QuickSand',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  shape: StadiumBorder(),
                  color: Colors.redAccent,
                  splashColor: Colors.teal,
                  height: 55,
                  minWidth: 100,
                  elevation: 2,
                )
              ], 
            ),
          ],
      ),
    );
  } 
}
    