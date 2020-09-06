import 'dart:ffi';
import 'dart:io';

import 'package:diabeteshelper/models/logbookmodel.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_porter/utils/csv_utils.dart';


class DatabaseProvider{
  DatabaseProvider._();

  static final  DatabaseProvider db = DatabaseProvider._();
  Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await getDatabaseInstanace();
    return _database;
  }

  Future<Database> getDatabaseInstanace() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "sdata.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Client ("
              "id integer primary key,"
              " activity TEXT,"
              " insulin TEXT,"
              " carbs TEXT,"
              " bg TEXT,"
              " datetime TEXT,"
              " notes TEXT"
              ")");
        });
  }
  Future<String> excel() async {

    final db = await database;


    final directory = await getExternalStorageDirectory();
    var path = directory.path;
    path = directory.path;
    var result = await db.query('Client');
    var csv = mapListToCsv(result);
    print(csv);

String nd = DateTime.now().toString();
    String dbPath = join(path, "${nd}report.csv");

    final File file = File(dbPath);
    await file.writeAsString(csv);
    print(dbPath);
    return dbPath;

  }
  Future<List<logmodel>> getAllClients() async {
    final db = await database;
    var response = await db.query("Client");
    List<logmodel> list = response.map((c) => logmodel.fromMap(c)).toList();
    return list;
  }
  Future<logmodel> sgownotes(int id) async {
    final db = await database;
    var response = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? logmodel.fromMap(response.first) : null;
  }

  Future<logmodel> getClientWithId(int id) async {
    final db = await database;
    var response = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? logmodel.fromMap(response.first) : null;
  }


  addClientToDatabase(logmodel client) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    int id = table.first["id"];
    client.id = id;
    var raw = await db.insert(
      "Client",
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;

  }


  deleteClientWithId(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }


  deleteAllClient() async {
    final db = await database;
    db.delete("Client");
  }


  updateClient(logmodel client) async {
    final db = await database;
    var response = await db.update("Client", client.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return response;
  }
}