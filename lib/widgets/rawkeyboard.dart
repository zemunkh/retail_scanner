import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './stockIn.dart';

class ScanKeyboard extends StatefulWidget {
  @override
  _ScanKeyboardState createState() => _ScanKeyboardState();
}

class _ScanKeyboardState extends State<ScanKeyboard> {
  final TextEditingController _scanController = TextEditingController();
  final FocusNode _scanNode = FocusNode();


  String _message = "";
  String buffer = "";
  String result = "";

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _scanNode.dispose();
  //   _scanController.dispose();
  //   super.dispose();
  // }


  void _handleKeyEvent(RawKeyEvent event) {
    if(event.runtimeType.toString() == 'RawKeyUpEvent') {
      setState(() {
        if(event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          if(buffer.isNotEmpty) {
            result = buffer;
            print('I am Enter: Value: $buffer');
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



  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

}