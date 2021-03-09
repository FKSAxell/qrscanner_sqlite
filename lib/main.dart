import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite/pages/home_page.dart';
import 'package:qrscanner_sqlite/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      initialRoute: 'home',
      routes: {
        'home':( _ ) => HomePage(),
        'mapa':( _ ) => MapaPage(),
      },
      
    );
  }
}