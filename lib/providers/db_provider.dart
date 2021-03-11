import 'dart:io';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
    // print(path);

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

  Future<ScanModel> getScanById(int id) async{
    final db = await database;
    final res = await db.query('Scans',where: 'id = ?',whereArgs: [id]) ;

    //res es el id del ultimo id insertado
    return res.isNotEmpty
           ? ScanModel.fromJson( res.first )
           : null;
  }

  Future<List<ScanModel>> getTodosLosScans() async{
    final db = await database;
    final res = await db.query('Scans') ;

    //res es el id del ultimo id insertado
    return res.isNotEmpty
           ? res.map((scan) => ScanModel.fromJson( scan )).toList()
           : [];
  }

    Future<List<ScanModel>> getScansPorTipo(String tipo) async{
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''') ;

    //res es el id del ultimo id insertado
    return res.isNotEmpty
           ? res.map((scan) => ScanModel.fromJson( scan )).toList()
           : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async{
    final db = await database;
    final res =await db.update(
        'Scans', 
        nuevoScan.toJson(),
        where:'id = ?', 
        whereArgs:[nuevoScan.id]
      );
    return res;
  }

  Future<int> deleteScan(int id) async{
    final db = await database;
    final res =await db.delete(
        'Scans', 
        where:'id = ?', 
        whereArgs:[id]
      );
    return res;
  }

  Future<int> deleteAllScans() async{
    final db = await database;
    final res =await db.delete(
        'Scans', 
      );
    return res;
  }

  Future<int> rawDeleteAllScans() async{
    final db = await database;
    final res =await db.rawDelete('''
    DELETE FROM Scans
    ''');
    return res;
  }


}