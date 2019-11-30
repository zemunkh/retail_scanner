import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/services.dart';
import './rawkeyboard.dart';


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

  bool firstInput = true;

  bool matched = false;
  bool oneToMany = false;
  var counter = 0;

  final FocusNode _scanNode = FocusNode();


  String _message = "";
  String buffer = "";
  String result = "";

  void _handleKeyEvent(RawKeyEvent event) {
    if(event.runtimeType.toString() == 'RawKeyUpEvent') {
      setState(() {
        if(event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          if(buffer.isNotEmpty) {
            result = buffer;
            print('I am Enter: Value: $buffer');
            if(firstInput) {
              _masterController.text = buffer;
              firstInput = false;
            } else {
              _productController.text = buffer;
              _compareData();
              firstInput = true;
            }
          }
          buffer = '';

        } else {
          var logicalKey = event.logicalKey.keyLabel;
          switch (logicalKey) {
            case '0':
              print('I am Zero');
              _message ='0';
              break;
            case '1':
              print('I am One');
              _message ='1';
              break;
            case '2':
              print('I am Two');
              _message ='2';
              break;
            case '3':
              print('I am Three');
              _message ='3';
              break;
            case '4':
              print('I am Four');
              _message ='4';
              break;
            case '5':
              print('I am Five');
              _message ='5';
              break;
            case '6':
              print('I am Six');
              _message ='6';
              break;
            case '7':
              print('I am Seven');
              _message ='7';
              break;
            case '8':
              print('I am Eight');
              _message ='8';
              break;
            case '9':
              print('I am Nine');
              _message ='9';
              break;
            default:
              print('I am Default');
              _message ='';
              break;
          }
          buffer = buffer + _message;
        }
      });
    }
  }

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
      // _masterController.clear();
      _productController.clear();
      counter = 0; 
    });
    print('Switch button value $oneToMany');
  }

  @override
  Widget build(BuildContext context) {
    // To hide keyboards on the restart.
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    return ListView(
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
                  // autofocus: false,
                  controller: _masterController,
                  focusNode: AlwaysDisabledFocusNode(),
                  onFieldSubmitted: (term) {
                    _masterNode.unfocus();
                    FocusScope.of(context).requestFocus(_productNode);
                  },
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
            child: RawKeyboardListener(
              focusNode: _scanNode,
              onKey: _handleKeyEvent,
              child: AnimatedBuilder(
                animation: _scanNode,
                builder: (BuildContext context, Widget child) {
                  if(!_scanNode.hasFocus) {
                    FocusScope.of(context).requestFocus(_scanNode);
                  }
                  return Container(
                    child: Text(_message ?? ' ',
                    style: TextStyle(color: Colors.black),),
                    
                  ); ///new Text(_message ?? 'press key');
                },
              ),
            ),
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
                    side: BorderSide(width: 1), 
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
                // textInputAction: TextInputAction.next,
                focusNode: AlwaysDisabledFocusNode(),
                onFieldSubmitted: (term) {
                  if(oneToMany) {
                    FocusScope.of(context).requestFocus(_productNode);
                  } else {
                    _productNode.unfocus();
                  }
                  _compareData();
                },
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
          Center(
            child: Transform.scale(
              scale: 2.0,
              child: Switch(
                value: oneToMany,
                activeColor: Colors.blueAccent,
                onChanged: (isOn) {
                  _enableOneToMany(isOn);
                },
              ),
            ),
          ),
          Center(
            child: Text('One to Many'),
          ),
        ],
    );
  } 
}
