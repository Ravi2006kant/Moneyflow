import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  //singleton - we can only access the db from one instance
  Dbhelper._();
  static Dbhelper getInstance() => Dbhelper._();

  // Database ? cause it can be null for the first time user
  Database? mDb;

  static const String dbName = "money_flow.db";
  static const String tablename = "transaction";
  static const String id = "id";
  static const String notes = "notes";
  static const String category = "category";
  static const String amount = "amount";
  static const String date = "date";
  static const String type = "type";

  //init database
  Future<Database> initdb() async {
    //if(mbd ==null){
    // openDb(); }
    mDb ??= await opendb();
    return mDb!;
  }

  //open database
  Future<Database> opendb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, dbName);
    return await openDatabase(
      dbPath,
      version: 1, //will change when changing the scheme/column
      onCreate: (db, _) {
        //help to execute and create tables
        db.execute(
          "create table $tablename ( $id integer primary key autoincrement,$notes text,$category text ,$date text,$amount integer ,$type text)",
        );
      },
    );
  }

  //adding notes
  void addNote({
    required String title,
    required String desc,
    required String category,
    required String amount,
    required String type,
  }) async {
    Database db = await initdb();
    db.insert(tablename, {
      notes: title,
      category: category,
      amount: amount,
      type: type,
      date: DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  //fetch notes
  Future<List<Map<String, dynamic>>> getallNotes() async {
    Database db = await initdb();
    return await db.query(tablename);
  }

  //update notes
  void updateNote({required int id}) async{
Database db = await initdb();
db.update(tablename,{

},where: "$notes = $id");

  }
  //delete notes
  void deleteNote({required int id}) {

  }
}
