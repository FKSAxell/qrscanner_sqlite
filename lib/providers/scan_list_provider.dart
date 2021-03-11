import 'package:flutter/material.dart';
import 'package:qrscanner_sqlite/models/scan_model.dart';
import 'package:qrscanner_sqlite/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans=[];
  String tipoSelecionado="http";

  nuevoScan(String valor) async {

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id=id; //asignar id de la base de datos

    if (this.tipoSelecionado == nuevoScan.tipo){
      scans.add(nuevoScan);
      notifyListeners(); //notificar a los widgets que deben ser redibujado
    }

  }


  cargarScans() async{
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];
    notifyListeners();

  }

  cargarScanPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    this.tipoSelecionado = tipo;
    notifyListeners();

  }

  borrarTodos () async{
    await DBProvider.db.deleteAllScans();
    this.scans=[];
    notifyListeners();

  }

  borrarScanPorId (int id) async{

    await DBProvider.db.deleteScan(id);
    cargarScanPorTipo(this.tipoSelecionado);

  }

  


}