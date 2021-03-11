import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscanner_sqlite/models/scan_model.dart';
import "package:sqflite/sqflite.dart";
export 'package:qrscanner_sqlite/models/scan_model.dart';


class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async{
    if(_database !=null) return _database;

    _database=await initDB();
    
    return _database;
  }

  Future<Database> initDB() async{

    //donde se almacena la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    // 123131312-312312321-31231321/ path raro
    final path = join(documentDirectory.path,'ScansDB.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db,int version) async {

        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )

        ''');

      }
    );

  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async{
    final id= nuevoScan.id;
    final tipo= nuevoScan.tipo;
    final valor= nuevoScan.valor;
    //verificar la base de datos
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO Scans(id, tipo, valor)
    VALUES ( '$id','$tipo','$valor' )
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async{
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    //res es el id del ultimo id insertado
    return res;
  }

}