import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

typedef SQL = Map<String, dynamic>?;
typedef SQLs = List<SQL>;

class YADB {
  static const _databaseName = "YouAlarm.db";
  static const _databaseVersion = 2;

  static const alarmsTable = "Alarm";
  static const alarmId = "alarmid";
  static const alarmDate = "alarmdate";

  static const soundsTable = "Sound";
  static const soundId = "soundid";
  static const soundTitle = "title";
  static const soundAuthor = "author";
  static const soundYId = "youtubeid";
  static const soundLocation = "location";
  static const soundDuration = "duration";
  static const soundThumbnail = "thumbnail";

  // Singleton this jaunt
  YADB._privateContstructor();

  static final YADB instance = YADB._privateContstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily init db first time it is accessed
    _database = await _initDb();
    return _database!;
  }

  // Opening or creating DB
  _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> setupDb(Database db) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS $alarmsTable (
        $alarmId INTEGER PRIMARY KEY,
        $alarmDate INTEGER NOT NULL,
        $soundId INTEGER NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE IF NOT EXISTS $soundsTable (
        $soundId INTEGER PRIMARY KEY,
        $soundTitle TEXT NOT NULL,
        $soundYId TEXT NOT NULL,
        $soundLocation TEXT NOT NULL,
        $soundDuration INTEGER NOT NULL,
        $soundThumbnail TEXT NOT NULL,
        $soundAuthor TEXT NOT NULL
      )
    """);
  }

  Future _onCreate(Database db, int version) async {
    await setupDb(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("---Impieza database---");
    print(newVersion > oldVersion);
    print(newVersion);
    print(oldVersion);
    print("---Termina database---");
    // Do stuff
    if (newVersion != oldVersion) {
      // Clear the database
      await db.execute("DROP TABLE IF EXISTS $alarmsTable");
      await db.execute("DROP TABLE IF EXISTS $soundsTable");

      // Now oncreate that hoe
      await setupDb(db);
    }
  }

  Future<SQL> query(String table, String column, int id) async {
    final Database db = await database;
    var res = await db.query(
      table,
      where: "$column = ?",
      whereArgs: [id],
    );

    if (res.isNotEmpty) {
      return res.first;
    }

    return null;
  }

  Future<SQLs?> queryTable(String table, {String? where}) async {
    final Database db = await database;
    var res = await db.query(
      table,
      where: where,
    );

    if (res.isNotEmpty) {
      return res;
    }

    return null;
  }

  void insert(String table, SQL data) async {
    final Database db = await database;
    await db.insert(
      table,
      data!,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void update(String table, SQL data) async {
    final Database db = await database;
    await db.update(
      table,
      data!,
      where: "$alarmId = ?",
      whereArgs: [data[alarmId]],
    );
  }

  void delete(String table, String column, int id) async {
    final Database db = await database;
    await db.delete(
      table,
      where: "$column = ?",
      whereArgs: [id],
    );
  }

  Future<SQL> getAlarm(int id) async {
    return await query(alarmsTable, alarmId, id);
  }

  Future<SQL> getSound(int id) async {
    return await query(soundsTable, soundId, id);
  }

  Future<SQLs?> getAlarms() async {
    return await queryTable(alarmsTable);
  }

  Future<SQLs?> getSounds() async {
    return await queryTable(soundsTable);
  }

  void insertAlarm(SQL alarm) {
    insert(alarmsTable, alarm);
  }

  void insertSound(SQL sound) {
    insert(soundsTable, sound);
  }

  void updateAlarm(SQL alarm) {
    update(alarmsTable, alarm);
  }

  void updateSound(SQL sound) {
    update(soundsTable, sound);
  }

  void deleteAlarm(int id) {
    delete(alarmsTable, alarmId, id);
  }

  void deleteSound(int id) {
    delete(soundsTable, soundId, id);
  }
}
