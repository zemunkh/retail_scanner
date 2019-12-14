import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrintNote {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

   sample(String pathImage) async {
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
        bluetooth.printCustom("Dispatch Note",3,1);
        bluetooth.printNewLine();
        bluetooth.printImage(pathImage);   //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Created At:", "2019/12/15",0);
        bluetooth.printLeftRight("Dispatch Number:", "123456R890",0);
        bluetooth.printLeftRight("Number of Items:", "12",0);
        bluetooth.printNewLine();
        bluetooth.printLeftRight("Stock Code:", "1234345",0);

        bluetooth.printCustom("Total Items: 5",2,1);
        bluetooth.printCustom("Matched Counter: 4",2,1);

        bluetooth.printCustom("Total Items: 5",2,1);
        bluetooth.printCustom("Matched Counter: 4",2,1);

        bluetooth.printCustom("Total Items: 5",2,1);
        bluetooth.printCustom("Matched Counter: 4",2,1);

        bluetooth.printNewLine();
        bluetooth.printCustom("Printed Time: 2019/12/16",0,1);

        // bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}