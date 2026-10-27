import 'dart:async';
import 'dart:io';
import 'package:moneyflow/pages/budget/addbudget.dart';
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

  Database? mDb;

  // Initialize database
  Future<Database> initdb() async {
    mDb ??= await opendb();
    return mDb!;
  }

  // Create/open database
  Future<Database> opendb() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String dbPath = join(appDir.path, dbName);

    return openDatabase(
      dbPath,
      version: 4,

      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS tracker (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          notes TEXT,
          category TEXT,
          date TEXT,
          amount REAL,
          type TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS budget (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          budgetName TEXT NOT NULL,
          category TEXT NOT NULL,
          spendingLimit REAL NOT NULL,
          month TEXT NOT NULL,
          alert INTEGER
        )
      ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS budget (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            budgetName TEXT NOT NULL,
            category TEXT NOT NULL,
            spendingLimit REAL NOT NULL,
            month TEXT NOT NULL,
            alert INTEGER
          )
        ''');
        }
      },
    );
  }

  // Add note
  Future<void> addNote({
    String? note,
    String? category,
    required String amount,
    required String type,
    required dateinput,
  }) async {
    final db = await initdb();
    await db.insert(tablename, {
      notes: note,
      Dbhelper.category: category,
      Dbhelper.amount: double.tryParse(amount) ?? 0.0,
      Dbhelper.type: type,
      date: dateinput,
    });
  }

  // Fetch all notes
  Future<List<Map<String, dynamic>>> getallNotes() async {
    final db = await initdb();
    return db.query(tablename, orderBy: '$id DESC');
  }

  Future<List<Map<String, dynamic>>> getTransactionByMonth(
      String month,
      ) async {
    final db = await initdb();
    return await db.query(
      tablename,
      where: 'date >= ? AND date < ?',
      whereArgs: [
        '$month-01',
        DateTime(
          int.parse(month.split('-')[0]),
          int.parse(month.split('-')[1]) + 1,
        ).toIso8601String().substring(0, 10),
      ],
      orderBy: 'date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getTransactionsByCategories() async {
    final db = await initdb();

    return await db.query(
      'tracker',
      where: 'category IN (?, ?, ?, ?, ?, ?)',
      whereArgs: [
        'salary',
        'food',
        'travel',
        'shopping',
        'bills',
        'other',
      ],
    );
  }
  Future<Map<String, double>> getExpenseCategoryTotalsByMonth(
      String month,
      ) async {
    final db = await initdb();

    final parts = month.split('-');
    final year = int.parse(parts[0]);
    final monthNumber = int.parse(parts[1]);

    final startDate = '$month-01';

    final endDate = DateTime(
      year,
      monthNumber + 1,
    ).toIso8601String().substring(0, 10);

    final categories = <String, double>{
      'food': 0.0,
      'travel': 0.0,
      'shopping': 0.0,
      'bills': 0.0,
      'other': 0.0,
    };

    final result = await db.rawQuery(
      '''
    SELECT
      LOWER(TRIM(category)) AS category,
      COALESCE(SUM(amount), 0) AS total
    FROM tracker
    WHERE LOWER(TRIM(type)) IN ('expense', 'expenses')
      AND date >= ?
      AND date < ?
      AND LOWER(TRIM(category)) IN (
        'food',
        'travel',
        'shopping',
        'bills',
        'other'
      )
    GROUP BY LOWER(TRIM(category))
    ''',
      [startDate, endDate],
    );

    for (final row in result) {
      final category = row['category'] as String;
      final total = (row['total'] as num).toDouble();

      categories[category] = total;
    }

    return categories;
  }
  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await initdb();

    return await db.query(
      'tracker',
      where: 'type = ?',
      whereArgs: ['expense'],
    );
  }

  Future<double> getTotalByMonth(
      String type,
      String month,
      ) async {
    final db = await initdb();

    final startDate = '$month-01';

    final parts = month.split('-');
    final nextMonth = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]) + 1,
    );

    final endDate = nextMonth.toIso8601String().substring(0, 10);

    final result = await db.rawQuery(
      '''
    SELECT COALESCE(SUM(amount), 0) AS total
    FROM $tablename
    WHERE type = ?
      AND date >= ?
      AND date < ?
    ''',
      [type, startDate, endDate],
    );

    return (result.first['total'] as num).toDouble();
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

    return db.update(tablename, values, where: '$id = ?', whereArgs: [id]);
  }

  // Delete one note
  Future<int> deleteNote({required int id}) async {
    final db = await initdb();

    return db.delete(tablename, where: 'id = ?', whereArgs: [id]);
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
    final records = await db.query(tablename, orderBy: '$id desc');
    return records;
  }

  //Budget
  Future<void> addbudget(
    int alert, {
    required String budgetName,
    required String category,
    required double spendingLimit,
    required String month,
  }) async {
    final db = await initdb();

    final data = await db.insert('budget', {
      'budgetName': budgetName,
      "category": category,
      "spendingLimit": spendingLimit,
      "month": month,
      "alert": alert,
    });
  }

  Future<double> getTotalBudgetForMonth(String month) async {
    final db = await initdb();

    final result = await db.rawQuery(
      '''
    SELECT COALESCE(SUM(spendinglimit), 0) AS total
    FROM budget
    WHERE month = ?
    ''',
      [month],
    );
    return (result.first['total'] as num).toDouble();
  }

  Future<List<Map<String, Object?>>> fetchbudgetCatefory() async {
    final db = await initdb();
    final rows = await db.query('budget',);
    return rows;
  }

  Future<List<Map<String, Object?>>> fetchBudget() async {
    final db = await initdb();
    final rows = await db.query('budget', orderBy: '$id desc');
    return rows;
  }

  Future<void> deleteAllBudget() async {
    final db = await initdb();
    db.delete('budget');
  }

  Future<void> deleteBudget(int delId) async {
    final db = await initdb();

    await db.delete(
      'budget',
      where: 'id = ?',
      whereArgs: [delId],
    );
  }
}
