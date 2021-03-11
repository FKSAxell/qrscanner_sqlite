import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner_sqlite/providers/ui_provider.dart';
class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectMenuOpt=i ,
      currentIndex: currentIndex,
      elevation: 0, //ojo
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
        BottomNavigationBarItem(icon: Icon(Icons.compass_calibration), label: "Direcciones")
      ],
      
    );
  }
}