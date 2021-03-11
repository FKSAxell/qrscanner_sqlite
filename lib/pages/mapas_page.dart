import 'package:flutter/material.dart';
class MapasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_,i){

        return ListTile(
          leading: Icon(Icons.map, color:Theme.of(context).primaryColor),
          title: Text("httpaxell.conha"),
          subtitle: Text("id:1"),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
          onTap: (){
            print("Abrir algo");
          },
        );

      },
      itemCount: 10,  
    );
  }
}