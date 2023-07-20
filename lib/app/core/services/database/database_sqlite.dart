
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseSqlite {
  static final  DatabaseSqlite _dbsqlite = DatabaseSqlite._internal();
  Database? _db ;

  factory DatabaseSqlite() {
    return _dbsqlite;
  }

  DatabaseSqlite._internal() {
    db;
  }

  Future<Database> get db async {
    _db ??= await initializeDatabase();
    return _db!;
  }

  final _databaseVersion = 1;

  // Script criação das tabelas
  static final createTableUser = '''
    CREATE TABLE ${DBTableName.users.value} (
      USR_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      USR_NAME TEXT NOT NULL,
      USR_EMAIL TEXT NOT NULL,
      USR_SENHA TEXT NOT NULL
    )
  ''';
  static final createTableCeps = '''
    CREATE TABLE ${DBTableName.ceps.value} (
      CEP_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      CEP_USR_ID INTEGER,
      CEP_NUM TEXT NOT NULL,
      CEP_LOGRADOURO TEXT NOT NULL,
      CEP_COMPLENTO TEXT NOT NULL,
      CEP_BAIRRO TEXT NOT NULL,
      CEP_LOCALIDADE TEXT NOT NULL,
      CEP_UF TEXT NOT NULL,
      CEP_IBGE TEXT NOT NULL,
      CEP_GIA TEXT NOT NULL,
      CEP_DDD TEXT NOT NULL,
      CEP_SIAFI TEXT NOT NULL,
      FOREIGN KEY (CEP_USR_ID) REFERENCES ${DBTableName.users.value} (USR_ID) 
      ON DELETE CASCADE
    )
  ''';

  // Método para inicializar o banco de dados
  Future<Database> initializeDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'database.db');

    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: (db, version) {
        db.execute(createTableUser);
        db.execute(createTableCeps);
      },
    );
  }
}

enum DBTableName {
  users('USERS'),
  ceps('CEPS');

  final String value;
  const DBTableName(this.value);
}