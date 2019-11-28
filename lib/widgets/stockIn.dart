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

  var counter = 0;

  void _compareData() {
    final masterCode = _masterController.text;
    final productCode = _productController.text;

    print('Comparison: $masterCode : $productCode');

    if(masterCode == productCode) {
      setState(() {
        counter++;
        _masterController.clear();
        _productController.clear();
      });
    }
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
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    EvaIcons.checkmarkCircleOutline,
                    size: 80,
                    color: Colors.green,
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
            height: 20,
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
            controller: _productController,
            textInputAction: TextInputAction.done,
            focusNode: _productNode,
            onFieldSubmitted: (term) {
              _productNode.unfocus();
              _compareData();
            },            

          ),
          SizedBox(height: 30,),
          Center(
            child: Transform.scale(
              scale: 2.0,
              child: Switch(
                activeColor: Colors.blueAccent,
                onChanged: (_) {},
                value: true,
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
