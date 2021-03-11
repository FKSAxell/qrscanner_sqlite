import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner_sqlite/providers/scan_list_provider.dart';
class ScanTiles extends StatelessWidget {
  
  final String tipo;

  const ScanTiles({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans =scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,  
      itemBuilder: (_,i){
      
        return Dismissible( // derecha izquierda
          key: UniqueKey(),
          background: Container(
            color: Colors.red
          ),
          onDismissed: (DismissDirection direction){
            //Provider.of<ScanListProvider>(context); // SE PUEDE HACER ESTO PERO CON EL listen FALSE
            scanListProvider.borrarScanPorId(scans[i].id);

          },
          child: ListTile(
            leading: Icon(
                this.tipo == 'http'
                ? Icons.compass_calibration
                : Icons.map, 
                color:Theme.of(context).primaryColor
              ),
            title: Text(scans[i].valor),
            subtitle: Text(scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: (){
              print(scans[i].id);
            },
          ),
        );

      },
      
    );
  }
}