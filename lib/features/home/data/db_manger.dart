import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  Database? _database;

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Initialization logic (including creation of tables)
    return await openDatabase(
      'islamna.db',
      version: 1,
      onCreate: (database, version) async {
        await _createTasbihTable(database);
        // Add other table creation logic here
      },
      onOpen: (database) {},
    );
  }

  Future<void> _createTasbihTable(Database database) async {
    await database.execute(
        'CREATE TABLE tasbih ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'name TEXT, '
            'counter INTEGER)'
    );
    // Additional logging or error handling can be added here
  }


  Future<bool> doesTableExist(String tableName) async {
    final db = await database;
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return tables.isNotEmpty;
  }

}
