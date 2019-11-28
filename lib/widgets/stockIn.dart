import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';


class StockIn extends StatefulWidget {
  @override
  _StockInState createState() => _StockInState();
}

class _StockInState extends State<StockIn> {
  final _masterController = TextEditingController();
  final _productController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
          TextField(
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
            controller: _masterController,
            // onSubmitted: (_) => submitData,
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
                    '0',
                    style: TextStyle(
                      fontSize: 80,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          TextField(
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
            // onSubmitted: (_) => submitData,
          ),
          SizedBox(height: 30,),
          Center(
            child: Switch(
              activeColor: Colors.blueAccent,
              onChanged: (_) {},
              value: true,
            ),
          ),
        ],
    );
  } 
}
