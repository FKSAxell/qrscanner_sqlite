import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner_sqlite/providers/scan_list_provider.dart';
import 'package:qrscanner_sqlite/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);

        // final barcodeScanRes = 'http://github.com/FKSAxell';
        //final barcodeScanRes = 'geo:45.280089,-75.922405';        
        print(barcodeScanRes);
        if(barcodeScanRes=='-1'){
          print(barcodeScanRes);
          return;
        }                   
        
        final scanListProvider = Provider.of<ScanListProvider>(context,listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
       

      }
    );
  }
}