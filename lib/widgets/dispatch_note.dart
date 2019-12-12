import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';



class DispatchNote extends StatefulWidget {
  @override
  DispatchNoteState createState() => DispatchNoteState();
}

class DispatchNoteState extends State<DispatchNote> {
  List<TextEditingController> _masterControllers = new List();
  List<TextEditingController> _productControllers = new List();

  List<FocusNode> _masterFocusNodes = new List();
  List<FocusNode> _productFocusNodes = new List();

  final _dispatchNoController = TextEditingController();
  final _numberOfScanController = TextEditingController();
  
  final _dispatchNode = FocusNode();
  final _numberNode = FocusNode();


  List<String> litems = [];

  Future<Null> _focusNode(BuildContext context, FocusNode node) async {
    FocusScope.of(context).requestFocus(node);
  }

  Future<Null> _clearTextController(BuildContext context, TextEditingController _controller, FocusNode node) async {
    setState(() {
      _controller.clear();
    });
    FocusScope.of(context).requestFocus(node);
  }


  @override
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    
    Widget _mainInput(String header, TextEditingController _mainController, FocusNode _mainNode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              '$header:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, 
                color: Color(0xFF004B83),
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment(1.0, 1.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 16, 
                        color: Color(0xFF004B83),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: header,
                        hintStyle: TextStyle(
                          color: Color(0xFF004B83), 
                          fontWeight: FontWeight.w200,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      autofocus: true,
                      controller: _mainController,
                      focusNode: _mainNode,
                      onTap: () {
                        _focusNode(context, _mainNode);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget _scannerInput(String hintext, TextEditingController _controller, FocusNode currentNode) {
      return Stack(
          alignment: const Alignment(2.0, 1.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 16, 
                    color: Color(0xFF004B83),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: Theme.of(context).textTheme.display1,
                    labelText: 'item: $hintext',
                    // labelText: TextStyle(
                    //   color: Color(0xFF004B83), 
                    //   fontWeight: FontWeight.w200,
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  autofocus: true,
                  controller: _controller,
                  focusNode: currentNode,
                  onTap: () {
                    _focusNode(context, currentNode);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                left: 32,
              ),
              child: FlatButton(
                onPressed: () {
                  _clearTextController(context, _controller, currentNode);
                },
                child: Icon(EvaIcons.close, color: Colors.blueAccent, size: 20,),
              ),
            ),
          ],
        );
    }

    Widget statusBar(bool matched) {
      return Row(children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: true ? new Icon(
                EvaIcons.checkmarkCircleOutline,
                size: 22,
                color: Colors.green,
              ) : new Icon(
                EvaIcons.closeCircleOutline,
                size: 22,
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(2),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(3),
                  ),
                  side: BorderSide(width: 1, color: Colors.black), 
                ),
              ),
              child: Center(
                child: Text(
                  '22',// counter.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget dateTime(String time) {
      return Text(
        time,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'QuickSand',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }

    // _getTextFieldList()

    if(_masterControllers.length == 0) {
      _masterControllers.add(new TextEditingController());
      _productControllers.add(new TextEditingController());

      _productControllers.add(new TextEditingController());
      _masterControllers.add(new TextEditingController());

      _masterFocusNodes.add(new FocusNode());
      _productFocusNodes.add(new FocusNode());

      _masterFocusNodes.add(new FocusNode());
      _productFocusNodes.add(new FocusNode());
    }


    // _scannerInput('hello', _controllers[index], _focusNodes[index]);


    
    String time = DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now());

    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: Column(
          children: <Widget>[
            dateTime(time),

            _mainInput('Dispatch Number',_dispatchNoController, _dispatchNode),

            _mainInput('Number of item',_numberOfScanController, _numberNode),

            new Expanded(
              child: new ListView.builder(
                itemCount: _masterControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      children: <Widget>[
                        SizedBox(height: 15,),
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              _scannerInput(index.toString(), _masterControllers[index], _masterFocusNodes[index],),
                              _scannerInput(index.toString(), _productControllers[index], _productFocusNodes[index],),
                            ],
                          ),
                        ),
                        Expanded(
                          child: statusBar(true),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


_getTextFieldList() async {
  List<TextEditingController> _controllers = new List();
  List<FocusNode> _focusNodes = new List();

  final prefs = await SharedPreferences.getInstance();
  final key = 'number_items';
  int fieldLength = prefs.getInt(key);

  return fieldLength;
}
