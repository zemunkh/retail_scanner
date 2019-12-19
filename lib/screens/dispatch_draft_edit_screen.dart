import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:retail_scanner/helper/file_manager.dart';
import 'package:retail_scanner/screens/dispatch_draft_screen.dart';
import 'package:retail_scanner/widgets/print_note.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DispatchDraftEditScreen extends StatefulWidget {
  static const routeName = '/draft_edit';
  @override
  DispatchDraftEditScreenState createState() => DispatchDraftEditScreenState();
}

class DispatchDraftEditScreenState extends State<DispatchDraftEditScreen> {

  List<TextEditingController> _masterControllers = new List();
  List<TextEditingController> _productControllers = new List();

  List<FocusNode> _masterFocusNodes = new List();
  List<FocusNode> _productFocusNodes = new List();

  final _dispatchNoController = TextEditingController();
  final _numberOfScanController = TextEditingController();
  
  final _dispatchNode = FocusNode();
  final _numberNode = FocusNode();

  List<String> _otherList = [];

  bool lockEn = true;
  bool _isButtonDisabled = true;

  // final _mainFormKey = GlobalKey<FormState>();
  // final _scannerFormKey = GlobalKey<FormFieldState>(); 

  PrintNote printNote;

  String createdDate = '';
  // Widget _form;
  List<bool> matchList = [false, false, false, false, false, false, false, false];
  List<int> counterList = [0, 0, 0, 0, 0, 0, 0, 0];


  Future<Null> _compareData(String prodVal, int index) async {
    final masterCode = _masterControllers[index].text;
    // final productCode = _productControllers[index].text;

    print('Comparison: $masterCode : $prodVal');

    setState(() {
      if(masterCode == prodVal) {
        matchList[index] = true;
        counterList[index]++;
      } else {
        matchList[index] = false;
      }
    });
  }

  String buffer = '';
  String trueVal = '';


  Future<Null> _dipatchNoListener() async {
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

  List<String> _masterList = [];
  List<String> _productList = [];
  List<String> _counterList = []; 
  List<String> draft_name = ['draft_master_', 'draft_product_', 'draft_counter_', 'draft_other_'];

  Future<Null> _numberScanListener() async {

    buffer = _numberOfScanController.text;
    if(buffer.endsWith(r'$')) {
      buffer = buffer.substring(0, buffer.length - 1);
      trueVal = buffer;

      if(_dispatchNoController.text != null) {
          _isButtonDisabled = false;
      }

      int draftIndex = await FileManager.getSelectedIndex();
      _masterList =  await FileManager.readDraft('draft_master_$draftIndex');
      _productList = await FileManager.readDraft('draft_product_$draftIndex');
      _counterList = await FileManager.readDraft('draft_counter_$draftIndex');

      await Future.delayed(const Duration(milliseconds: 1000), (){
        _numberOfScanController.text = trueVal;
      }).then((value){
        
        // set the number of inputs will be built in the screen 
        if(int.parse(trueVal) < 9) {
          _setNumberItems(int.parse(trueVal));
          
          print('Controller Length: ${_masterControllers.length}');

          if(_masterControllers.length < int.parse(trueVal) ) {
            int diff = int.parse(trueVal) - _masterControllers.length;
            setState(() {
              for(int i = 0; i < diff; i++) {
                print('adding:');
                _masterControllers.add(new TextEditingController());
                _productControllers.add(new TextEditingController());

                _masterControllers[i].text = _masterList[i];
                _productControllers[i].text = _productList[i];
                counterList[i] = int.parse(_counterList[i]);
                if(counterList[i] > 0) {
                  matchList[i] = true;
                }
                _masterFocusNodes.add(new FocusNode());
                _productFocusNodes.add(new FocusNode());
              }
              if(_dispatchNoController.text != null) {
                _isButtonDisabled = false;
              }

            });
          } else {
            print('Wrong request!');
            // _onBasicAlertPressed(BuildContext context);
          }
        } else {
          _setNumberItems(8);
          print('Too many :(');
        } 
        _numberNode.unfocus();
        FocusScope.of(context).requestFocus(new FocusNode());
      });
    }
  }


  Future<Null> _focusNode(BuildContext context, FocusNode node) async {
    FocusScope.of(context).requestFocus(node);
  }

  Future<Null> _clearTextController(BuildContext context, TextEditingController _controller, FocusNode node) async {
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _controller.clear();
      });
      FocusScope.of(context).requestFocus(node);
    });
  }

  _controllerEventListener(int index, TextEditingController _controller, String _typeController) {
    int length = _masterControllers.length;
    print('Length of the controllers: $length, index: $index');
    if(_typeController == 'master') {
      buffer = _masterControllers[index].text;
    } else if(_typeController == 'product') {
      buffer = _productControllers[index].text;
    }
    
      if(buffer.endsWith(r'$')){
        buffer = buffer.substring(0, buffer.length - 1);
        trueVal = buffer;
        if(_typeController == 'master') {
          print('I am master!');
          _masterFocusNodes[index].unfocus();
        } else if(_typeController == 'product') {
          print('I am product!');
          _productFocusNodes[index].unfocus();
          _compareData(trueVal, index);
        } else {
          print('Nothing to do');
        }
        
        Future.delayed(const Duration(milliseconds: 200), (){
          setState(() {
            _controller.text = trueVal;
          });
          if(length < 8) {
            if(_typeController == 'master') {
              FocusScope.of(context).requestFocus(_productFocusNodes[index]);
            } else if(_typeController == 'product') {
              if((length - 1) > index){
                FocusScope.of(context).requestFocus(_masterFocusNodes[index + 1]);
              } else {
                FocusScope.of(context).requestFocus(new FocusNode());
              }
              
            }
          }
        });
      }
  }

  Future<Null> _saveAndPrint(String createdDate) async {

    String currentTime = DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now());
    // String createdAt = DateFormat("yyyyMMdd").format(createdDate);
    String createdAt = createdDate;
    List<String> draftList = [];
    int len = _masterControllers.length;
    
    int draftIndex = await FileManager.getSelectedIndex();

    String deviceName = await FileManager.readProfile('device_name');
    if(deviceName.isEmpty) {
      deviceName = 'Unknown';
    }
    String userName = await FileManager.readProfile('user_name');
    if(userName.isEmpty) {
      userName = 'Unknown';
    }
    String companyName = await FileManager.readProfile('company_name');
    if(companyName.isEmpty) {
      companyName = 'Unknown';
    }
    String remark1 = await FileManager.readProfile('remark1');
    if(remark1.isEmpty) {
      remark1 = 'Unknown';
    }
    String remark2 = await FileManager.readProfile('remark2');
    if(remark2.isEmpty) {
      remark2 = 'Unknown';
    }
    List<String> _masterList = [];
    List<String> _productList = [];
    List<String> _counterList = [];  // Matched Counter Value
    
    if(_dispatchNoController.text != null || _numberOfScanController.text != null) {
      for(int i = 0; i < len; i++) {
        String buff = '$createdAt, ${_dispatchNoController.text}, ${_numberOfScanController.text}, ${_masterControllers[i].text}, ${_productControllers[i].text}, ${counterList[i].toString()}, $currentTime, $deviceName, $userName\r\n';    
        draftList.add(buff);
        _masterList.add(_masterControllers[i].text);
        _productList.add(_productControllers[i].text);
        _counterList.add(counterList[i].toString());
      }
    }
    print('List Data: $draftList');
    FileManager.saveDispatchData(createdAt, draftList);
    // prepare the passing value

    FileManager.removeDraft('draft_master_$draftIndex');
    FileManager.removeDraft('draft_product_$draftIndex');
    FileManager.removeDraft('draft_counter_$draftIndex');
    FileManager.removeDraft('draft_other_$draftIndex');
    FileManager.removeFromBank(draftIndex);
    // start print operation
    printNote.sample(deviceName, userName, companyName, remark1, remark2, createdAt, _dispatchNoController.text, _numberOfScanController.text, _masterList, _productList, _counterList, currentTime);
  }

  void initDraftScreen() async {
 // Matched Counter Value
    int draftIndex = await FileManager.getSelectedIndex();
    print('Selected number: $draftIndex');
    _otherList = await FileManager.readDraft('draft_other_$draftIndex');
    print('Other list: $_otherList');
    setState(() {
      createdDate = _otherList[0];
      _dispatchNoController.text = _otherList[1];
      _numberOfScanController.text = _otherList[2] + r'$';
    });
  }

  Future<bool> _backButtonPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit the Stock App?"),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      )
    );
  }


  @override
  void dispose() {
    super.dispose();
    _dispatchNoController.dispose();
    _numberOfScanController.dispose();
  }

  @override
  void initState() {
    printNote = PrintNote();
    _dispatchNoController.addListener(_dipatchNoListener);
    _numberOfScanController.addListener(_numberScanListener);
    initDraftScreen();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {

    // final DraftScreenArguments args = ModalRoute.of(context).settings.arguments;
    
    // var draftname = args.name;
    // var draftIndex = args.draftIndex;
    // _otherList =  await FileManager.readDraft('draft_other_${args.draftIndex}');

    Widget _mainInput(String header, TextEditingController _mainController, FocusNode _mainNode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              '$header:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, 
                color: Color(0xFF004B83),
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          Expanded(
            flex: 7,
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
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(EvaIcons.close, 
                            color: Colors.blueAccent, 
                            size: 32,
                          ),
                          onPressed: () {
                            _clearTextController(context, _mainController, _mainNode);
                          },
                        ),
                      ),
                      autofocus: true,
                      controller: _mainController,
                      validator: (String value) {
                        if(value.isEmpty) {
                          return 'Enter Scan Number';
                        } else if(int.parse(value) >= 9){
                          return 'Too much. Suggestion: 1-8';
                        }
                      },
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

    Widget _scannerInput(String typeController, TextEditingController _controller, FocusNode currentNode, int index) {
      return Stack(
          alignment: const Alignment(1.4, 1.0),
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
                  enabled: typeController == 'master' ? false : true,
                  decoration: InputDecoration.collapsed(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: typeController,
                    hintStyle: TextStyle(
                      color: Color(0xFF004B83),
                      fontSize: 16, 
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  autofocus: true,
                  controller: _controller,
                  focusNode: currentNode,
                  onTap: () {
                    _clearTextController(context, _controller, currentNode);
                    // _focusNode(context, currentNode);
                  },
                  onChanged: (value){
                    _controllerEventListener(index, _controller, typeController);
                  },
                ),
              ),
            ),
          ],
        );
    }

    Widget statusBar(int index) {
      return Row(children: <Widget>[
        Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: matchList[index] ? new Icon(
                FontAwesomeIcons.solidCircle,
                size: 30,
                color: Colors.green,
              ) : new Icon(
                FontAwesomeIcons.solidCircle,
                size: 30,
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
                  counterList[index].toString(),// counter.toString(),
                  style: TextStyle(
                    fontSize: 24,
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
          fontSize: 16,
          color: Colors.black,
        ),
      );
    }

    Widget _printAndOkButton() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          onPressed: _isButtonDisabled ? null : () {
            print('You pressed Save and Print Button!');

            _saveAndPrint(createdDate).then((_){
              setState(() {
                lockEn = false;
              });
              Navigator.of(context).pushReplacementNamed(DispatchDraftScreen.routeName);
            });
          },
          child: Text(
            'Save & Print',
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
          height: 30,
          minWidth: 100,
          elevation: 2,
        )
      );
    }  
    
    
    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Draft Edit Page'),
          leading: IconButton(
            icon: Icon(
              EvaIcons.arrowBack,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(DispatchDraftScreen.routeName);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Column(
              children: <Widget>[
                dateTime(createdDate),

                _mainInput('Dispatch No',_dispatchNoController, _dispatchNode),
                _mainInput('Total Items',_numberOfScanController, _numberNode),
                SizedBox(height: 15,),
                new Expanded(
                    child: new ListView.builder(
                      itemCount: _masterControllers?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text('Item: $index'),
                                    _scannerInput('master', _masterControllers[index], _masterFocusNodes[index], index),
                                    _scannerInput('product', _productControllers[index], _productFocusNodes[index], index),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: statusBar(index),
                              ),
                            ],
                          ),
                        );
                      },
                      
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: _printAndOkButton(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


_setNumberItems(int val) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'number_items';
  prefs.setInt(key, val);
  print('Items set to $val');
}