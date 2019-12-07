import 'package:flutter/material.dart';
import '../styles/theme.dart' as Style;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';



class ActivationScreen extends StatelessWidget {
  static const routeName = '/activation';

  final _activationController = TextEditingController();
  final FocusNode _activationNode = FocusNode();

  Future<Null> _focusNode(BuildContext context, FocusNode node) async {
    FocusScope.of(context).requestFocus(node);
  }

  @override
  Widget build(BuildContext context) {

    Widget _activationInput(String labeltext, TextEditingController _controller, FocusNode currentNode) {
      return Stack(
        alignment: const Alignment(1.0, 1.0),
        children: <Widget>[
          Container(
            child: TextFormField(
              style: TextStyle(
                fontSize: 22, 
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelStyle: Theme.of(context).textTheme.display1,
                labelText: labeltext,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
              controller: _controller,
              focusNode: currentNode,
              onTap: () {
                _focusNode(context, currentNode);
              },
            ),
          ),
        ],
      );
    }


    final logoStyle = TextStyle(
      fontFamily: 'QuickSand',
      fontWeight: FontWeight.w500,
      color: Colors.grey[700],
      fontSize: 36.0,
    );

    final logo = Card(
      elevation: 0,
      color: Style.Colors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('assets/images/barcode-icon.png'),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Retail',
              style: logoStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Scanner',
              style: logoStyle,
            ),
          ),
        ],
      ),
    );

    final button = Padding(
      padding: EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          String inputText = _activationController.text;
          print('$inputText');
        },
        child: Text(
          'Activate',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        shape: StadiumBorder(),
        color: Colors.blue,
        splashColor: Colors.teal,
        height: 55,
        minWidth: 350,
        elevation: 2,
      )
    ); 

    final mainView = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        logo,
        Padding(
          padding: EdgeInsets.all(10),
          child: _activationInput('Activation input', _activationController, _activationNode),
        ),        
        button,
      ], 
    );  

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Others Page'),
      // ),
      backgroundColor: Style.Colors.background,
      body: Center(
        child: mainView,
      ),
    );
  }
}