
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Dbhelper._();

  static final Dbhelper _instance = Dbhelper._();
  static Dbhelper getInstance() => _instance;

  static const String dbName = 'money_flow.db';
  static const String tablename = 'tracker';
  static const String id = 'id';
  static const String notes = 'notes';
  static const String category = 'category';
  static const String amount = 'amount';
  static const String date = 'date';
  static const String type = 'type';

  final now = DateTime.now();
  Database? mDb;

  // Initialize database
  Future<Database> initdb() async {
    mDb ??= await opendb();
    return mDb!;
  }

  // Create/open database
  Future<Database> opendb() async {
    final Directory appDir =
    await getApplicationDocumentsDirectory();

    final String dbPath = join(appDir.path, dbName);

    return openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $notes TEXT,
            $category TEXT,
            $date TEXT,
            $amount REAL,
            $type TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tablename (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $notes TEXT,
            $category TEXT,
            $date TEXT,
            $amount REAL,
            $type TEXT
          )
        ''');
      },
    );
  }

  // Add note
  Future<void> addNote({
    String? note,
    String? category,
    required String amount,
    required String type,
  }) async {
    final db = await initdb();
    final formattedDate =
    DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
    await db.insert(tablename, {
      notes: note,
      Dbhelper.category: category,
      Dbhelper.amount: double.tryParse(amount) ?? 0.0,
      Dbhelper.type: type,
      date: formattedDate,
    });
  }

  // Fetch all notes
  Future<List<Map<String, dynamic>>> getallNotes() async {
    final db = await initdb();
    return db.query(tablename, orderBy: '$id DESC');
  }

  // Update note
  Future<int> updateNote({
    required int id,
    String? note,
    String? category,
    String? amount,
    String? type,
  }) async {
    final db = await initdb();

    final Map<String, dynamic> values = {};

    if (note != null) values[notes] = note;
    if (category != null) values[Dbhelper.category] = category;
    if (amount != null) {
      values[Dbhelper.amount] = double.tryParse(amount) ?? 0.0;
    }
    if (type != null) values[Dbhelper.type] = type;

    if (values.isEmpty) return 0;

    return db.update(
      tablename,
      values,
      where: '$id = ?',
      whereArgs: [id],
    );
  }

  // Delete one note
  Future<int> deleteNote({required int id}) async {
    final db = await initdb();

    return db.delete(
      tablename,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all rows (table remains)
  Future<void> allDeleteNote() async {
    final db = await initdb();
    await db.delete(tablename);
    print('All tracker records deleted');
  }

  // Calculate total by type
  Future<double> getTotal(String type) async {
    final db = await initdb();

    final result = await db.rawQuery(
      'SELECT SUM(amount) AS total FROM $tablename WHERE type = ?',
      [type],
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  // Print all notes in Debug Console

  Future<List<Map<String, Object?>>> viewAllNotes() async {
    final db = await initdb();
    final records = await db.query(tablename ,orderBy: '$id desc');
    return records;
  }

  //returning a list of map

}
