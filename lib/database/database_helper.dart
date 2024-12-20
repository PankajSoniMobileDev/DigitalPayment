import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/model/transaction_model.dart';

class DatabaseHelper {
  // Singleton DatabaseHelper instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create the transactions table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        status TEXT,
        dateTime TEXT
      )
    ''');
  }

  // Insert a new transaction
  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch all transactions
  Future<List<TransactionModel>> fetchTransactions() async {
    final db = await instance.database;
    final result = await db.query('transactions');

    // Convert the List<Map<String, dynamic>> to List<TransactionModel>
    return result.map((map) {
      return TransactionModel.fromMap(map);
    }).toList();
  }

  // Delete all transactions (optional)
  Future<int> deleteAllTransactions() async {
    final db = await instance.database;
    return await db.delete('transactions');
  }
}