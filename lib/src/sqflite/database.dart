import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:testbot/src/common_name.dart';
import 'package:testbot/src/model/chat_data_model.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final instance = DatabaseHelper._();

  static late Database _database;

  static String tableName = 'ChatDataTable';
  static String appName = 'ApplicationName';
  static String clientId = 'ClientId';
  static String question1 = 'Level1';
  static String question2 = 'Level2';
  static String question3 = 'Level3';
  static String question4 = 'Level4';
  static String question5 = 'Level5';
  static String status = 'Status';

  Future<Database> get database async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "main.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table ${DatabaseHelper.tableName} ( 
          ${DatabaseHelper.appName} text,
          ${DatabaseHelper.clientId} text,            
          ${DatabaseHelper.question1} text,
          ${DatabaseHelper.question2} text,
          ${DatabaseHelper.question3} text,
          ${DatabaseHelper.question4} text,
          ${DatabaseHelper.question5} text,
          ${DatabaseHelper.status} 

          )
          ''');
      },
    );

    final tables =
        await _database.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    return _database;
  }

  DatabaseHelper.internal();

  // Future<FavouriteSqfliteModel> insert(FavouriteSqfliteModel user) async {
  //   var dbClient = await db;
  //   user.id = await dbClient.insert(tableName, user.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return user;
  // }

  // Future<FavouriteSqfliteModel?> getUser(int id) async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query(tableName,
  //       columns: [
  //         columnId,
  //       ],
  //       where: '$columnId = ?',
  //       whereArgs: [id]);
  //   if (maps.length > 0) {
  //     return FavouriteSqfliteModel.fromMap(maps.first);
  //   }
  //   return null;
  // }

  // Future<int> delete(String id, String client) async {
  //   var dbClient = await db;
  //   return await dbClient.delete(tableName,
  //       where: '$columnJobId = ? and $columnClientId = ?',
  //       whereArgs: [id, client]);
  // }

  // Future<int> update(FavouriteSqfliteModel favouriteSqfliteModel) async {
  //   var dbClient = await db;
  //   return await dbClient.update(tableName, favouriteSqfliteModel.toMap(),
  //       where: '$columnId = ?', whereArgs: [favouriteSqfliteModel.id]);
  // }

//   Future<List<FavouriteSqfliteModel>> getAllUsers() async {
//     List<FavouriteSqfliteModel> favouriteSqfliteModelList = [];
//     var dbClient = await db;
//     List<Map> maps = await dbClient.query(tableName, columns: [
//       columnId,
//       columnCandidateId,

//     ]);
//     if (maps.length > 0) {
//       maps.forEach((f) {
//         favouriteSqfliteModelList.add(FavouriteSqfliteModel.fromMap(f));
// //          print("getAllUsers"+ User.fromMap(f).toString());
//       });
//     }
//     return favouriteSqfliteModelList;
//   }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }
}
