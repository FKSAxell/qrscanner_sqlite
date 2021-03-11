import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner_sqlite/pages/direcciones_page.dart';
import 'package:qrscanner_sqlite/providers/db_provider.dart';
import 'package:qrscanner_sqlite/providers/ui_provider.dart';
import 'package:qrscanner_sqlite/widgets/custom_navigatorbar.dart';
import 'package:qrscanner_sqlite/widgets/scan_button.dart';

import 'mapas_page.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation:0,
        title:Text('Historial'),
        actions:[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: (){})
        ],
      ),
      body: _HomePageBody(),

      
      bottomNavigationBar:CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
      
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    //obtener el selectedmenuopt
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectMenuOpt;

    //TODO: temporal leer la base de datos
    final tempScan = new ScanModel(valor: "http://google.com");
    DBProvider.db.nuevoScan(tempScan);


    switch (currentIndex) {
      case 0 :
        return MapasPage();
      case 1 :
        return DireccionesPage();   
      default:
        return MapasPage();

    }


  }
}