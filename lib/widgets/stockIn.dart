import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/services.dart';


class StockIn extends StatefulWidget {
  @override
  _StockInState createState() => _StockInState();
}

class _StockInState extends State<StockIn> {
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
          _masterController.clear();
          _productController.clear();
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


  @override
  Widget build(BuildContext context) {
    // To hide keyboards on the restart.
    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
              TextFormField(
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
                textInputAction: TextInputAction.next,
                focusNode: _masterNode,
                onFieldSubmitted: (term) {
                  _masterNode.unfocus();
                  FocusScope.of(context).requestFocus(_productNode);
                },
              ),
              FlatButton(
                onPressed: () {
                  _masterController.clear();
                },
                child: Icon(EvaIcons.refresh, color: Colors.white, size: 30,),
              ),
            ],
          ),

          SizedBox(height: 10),
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
                autofocus: true,
                controller: _productController,
                textInputAction: TextInputAction.next,
                focusNode: _productNode,
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
