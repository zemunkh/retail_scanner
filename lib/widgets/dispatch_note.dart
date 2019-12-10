import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';



class DispatchNote extends StatefulWidget {
  @override
  DispatchNoteState createState() => DispatchNoteState();
}

class DispatchNoteState extends State<DispatchNote> {

  @override 
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Center(
        child: new ListTile(
          title: Text('List'),
          trailing: new Container(
            width: 100.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                    flex: 3,
                    child: new TextField(
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration.collapsed(hintText: 'Zee'),
                  ),
                ),
                new Expanded(
                    child: new IconButton(
                    icon: new Icon(Icons.chevron_right),
                    color: Colors.black26,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// class DispatchScreen extends StatelessWidget {
//   static const routeName = '/dispatch';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Dispatch Page'),
//       // ),
//       drawer: MainDrawer(),
//       body: Center(
//         child: Text(
//           'Dispatch Note',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Colors.blue,
//             fontSize: 25.0,
//           ),
//         ),
//       ),
//     );
//   }
// }