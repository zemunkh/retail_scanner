import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';



class DispatchNote extends StatefulWidget {
  @override
  DispatchNoteState createState() => DispatchNoteState();
}

class DispatchNoteState extends State<DispatchNote> {
  List<TextEditingController> _controllers = new List();
  List<FocusNode> _focusNodes = new List();



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
    

    Widget _scannerInput(String hintext, TextEditingController _controller, FocusNode currentNode) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              'item: $hintext',
              style: TextStyle(
                fontSize: 22, 
                color: Color(0xFF004B83),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              alignment: const Alignment(2.0, 1.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 22, 
                        color: Color(0xFF004B83),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: hintext,
                        hintStyle: TextStyle(
                          color: Color(0xFF004B83), 
                          fontWeight: FontWeight.w200,
                        ),
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
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment(1.0, 1.0),
              
              children: <Widget>[
                Padding(
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
                Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(2),
                  // decoration: ShapeDecoration(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(
                  //         Radius.circular(3),
                  //     ),
                  //     side: BorderSide(width: 1, color: Colors.black), 
                  //   ),
                  // ),
                  child: Center(
                    child: Text(
                      '22',// counter.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }


    // _getTextFieldList()


    // _controllers.add(new TextEditingController());
    // _focusNodes.add(new FocusNode());

    // _scannerInput('hello', _controllers[index], _focusNodes[index]);

    for(int i = 0; i < 8; i++) {
      _focusNodes.add(new FocusNode());
      _controllers.add(new TextEditingController());
    }
    
    String time = DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now());

    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              time,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'QuickSand',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            new Expanded(
              child: new ListView.builder(
                itemCount: _controllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 15,),
                      _scannerInput(index.toString(), _controllers[index], _focusNodes[index]),
                    ],
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
