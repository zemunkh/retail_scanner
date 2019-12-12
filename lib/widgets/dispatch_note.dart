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


  bool matched = false;
  int counter = 0;


  Future<Null> _compareData() async {
    final masterCode = _dispatchNoController.text;
    final productCode = _numberOfScanController.text;

    print('Comparison: $masterCode : $productCode');

    setState(() {
      if(masterCode == productCode) {
        matched = true;
        counter++;
      } else {
        matched = false;
      }
    });
  }

  String buffer = '';
  String trueVal = '';


  Future<Null> dipatchNoListener() async {
    print('Current text: ${_dispatchNoController.text}');
    buffer = _dispatchNoController.text;
    if(buffer.endsWith(r'$')){
      buffer = buffer.substring(0, buffer.length - 1);
      trueVal = buffer;
      _dispatchNode.unfocus();
      await Future.delayed(const Duration(milliseconds: 200), (){
        setState(() {
          _dispatchNoController.text = trueVal;
        });
        FocusScope.of(context).requestFocus(_numberNode);
      });
    }
  }


  Future<Null> _numberScanListener() async {
    buffer = _numberOfScanController.text;
    if(buffer.endsWith(r'$')) {
      buffer = buffer.substring(0, buffer.length - 1);
      trueVal = buffer;

      await Future.delayed(const Duration(milliseconds: 1000), (){
        _numberOfScanController.text = trueVal;
      }).then((value){
        _compareData();
          
        _numberNode.unfocus();
        FocusScope.of(context).requestFocus(new FocusNode());
      });
    }
  }


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

    Widget _scannerInput(String hintext, TextEditingController _controller, FocusNode currentNode, int index) {
      return Stack(
          alignment: const Alignment(1.4, 1.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 20, 
                    color: Color(0xFF004B83),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: hintext,
                    hintStyle: TextStyle(
                      color: Color(0xFF004B83),
                      fontSize: 20, 
                      fontWeight: FontWeight.w300,
                    ),
                    // labelStyle: TextStyle(
                    //   color: Color(0xFF004B83),
                    //   fontSize: 16, 
                    //   fontWeight: FontWeight.w600,
                    // ),
                    // labelText: 'item: $hintext',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(EvaIcons.close, 
                        color: Colors.blueAccent, 
                        size: 32,
                      ),
                      onPressed: () {
                        _clearTextController(context, _controller, currentNode);
                      },
                    ),
                    
                  ),
                  autofocus: true,
                  controller: _controller,
                  focusNode: currentNode,
                  onTap: () {
                    _focusNode(context, currentNode);
                  },
                  onChanged: (value){
                    print('Text: $value');
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(2),
            //   child: FlatButton(
            //     onPressed: () {
            //       _clearTextController(context, _controller, currentNode);
            //     },
            //     child: Icon(EvaIcons.close, color: Colors.blueAccent, size: 32,),
            //   ),
            // ),
          ],
        );
    }

    Widget statusBar(bool matched) {
      return Row(children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: matched ? new Icon(
                EvaIcons.checkmarkCircleOutline,
                size: 50,
                color: Colors.green,
              ) : new Icon(
                EvaIcons.closeCircleOutline,
                size: 50,
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
                  '80',// counter.toString(),
                  style: TextStyle(
                    fontSize: 50,
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
          fontSize: 30,
          color: Colors.black,
        ),
      );
    }

    Widget _saveDraftButton() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          onPressed: () {
            print('I am pressed');
          },
          child: Text(
            'Print & Ok',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          shape: StadiumBorder(),
          color: Colors.orange[800],
          splashColor: Colors.yellow[200],
          height: 50,
          minWidth: 200,
          elevation: 2,
        )
      );
    } 

    Widget _printAndOkButton() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          onPressed: () {
            print('I am pressed');
          },
          child: Text(
            'Save as Draft',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          shape: StadiumBorder(),
          color: Colors.teal[400],
          splashColor: Colors.blue[100],
          height: 50,
          minWidth: 200,
          elevation: 2,
        )
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
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text('Item: $index'),
                              _scannerInput(index.toString(), _masterControllers[index], _masterFocusNodes[index], index),
                              _scannerInput(index.toString(), _productControllers[index], _productFocusNodes[index], index),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: _saveDraftButton(),
                ),
                Expanded(
                  child: _printAndOkButton(),
                )
              ],
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
