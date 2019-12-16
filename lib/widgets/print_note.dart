import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrintNote {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  // createdAt, _dispatchNoController.text, _numberOfScanController.text, _masterList, _productList, _counterList, currentTime
   sample(String dname, String username, String createdAt, String _dispatchNo, String _totalNumber, List<String> _masterList, List<String> _productList, List<String> _counterList, String currentTime) async {

    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("Dispatch Note:",3,1);
        bluetooth.printCustom("Device ID: $dname",2,0);
        bluetooth.printCustom("Username: $username",2,0);
        bluetooth.printNewLine();
        // bluetooth.printImage(pathImage);   //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Created At: $createdAt", '',2);
        bluetooth.printLeftRight("Dispatch Number: $_dispatchNo", '',2);
        bluetooth.printLeftRight("Total Items: $_totalNumber", '',2);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        for(int i = 0; i < _masterList.length; i++) {
          bluetooth.printLeftRight("#${i+1} Stock Code: ${_masterList[i]}", '',2);
          bluetooth.printLeftRight("#${i+1} Product Code: ${_productList[i]}", '',2);
          bluetooth.printCustom("Matched Counter: ${_counterList[i]}",2,0);
        }
        bluetooth.printNewLine();
        bluetooth.printCustom("Printed Time: $currentTime",2,0);
        // bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}