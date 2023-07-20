


import '../services/database/database_sqlite.dart';
export 'package:sqflite/sqflite.dart';

abstract class LocalServiceRepo {
  final DatabaseSqlite data = DatabaseSqlite();

}