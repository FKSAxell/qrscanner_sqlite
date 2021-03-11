import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner_sqlite/pages/home_page.dart';
import 'package:qrscanner_sqlite/pages/mapa_page.dart';
import 'package:qrscanner_sqlite/providers/scan_list_provider.dart';
import 'package:qrscanner_sqlite/providers/ui_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
            return UiProvider();
          },
        ),

        ChangeNotifierProvider(create: (_){
            return ScanListProvider();
          },
        )
        
      ],
      
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home':( _ ) => HomePage(),
          'mapa':( _ ) => MapaPage(),
        },

        //temas en flutter
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )

        ),
        
      ),
    );
  }
}