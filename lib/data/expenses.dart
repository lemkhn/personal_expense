import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String TBL_Expense = "expense";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_AMOUNT = "amount";
  static const String COLUMN_DATE = "date";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print('db getter');

    if (_database != null) {
      return _database;
    } else {
      _database = await createDatabase();

      return _database;
    }
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'expenseDB.db'), version: 1,
        onCreate: (Database database, int version) async {
      await database.execute("CREATE TABLE $TBL_Expense ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_TITLE TEXT,"
          "$COLUMN_AMOUNT DECIMAL(10,5),"
          "$COLUMN_DATE DATETIME)");
    });
  }
}
