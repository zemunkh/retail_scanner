import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';



class ActivationScreen extends StatelessWidget {
  static const routeName = '/activation';

  final _activationController = TextEditingController();
  final FocusNode _activationNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    Widget _activationInput(String hintext, TextEditingController _controller, FocusNode currentNode) {
      return Stack(
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
                hintText: hintext,
                hintStyle: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w200,
                ),
              ),
              autofocus: true,
              controller: _controller,
              focusNode: currentNode,
              onTap: () {
                // _focusNode(context, currentNode);
              },
            ),
          ),
          FlatButton(
            onPressed: () {
              // _clearTextController(context, _controller, currentNode);
              // if(_controller == _masterController) {
              //   _productController.clear();
              // }
            },
            child: Icon(EvaIcons.closeOutline, color: Colors.white, size: 30,),
          ),
        ],
      );
    }


    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Others Page'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              child: Image.asset('assets/images/barcode-icon.png'),

            ),
            Text(
              'Activation',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.blue,
                fontSize: 25.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: _activationInput('Please insert Activation code', _activationController, _activationNode),
            )
            
          ], 
        ),
      ),
    );
  }
}