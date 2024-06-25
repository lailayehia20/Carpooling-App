


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class mydatabaseclass {
  Database? mydb;

  Future<Database?> mydbcheck() async {
    if (mydb == null) {
      mydb = await initiatedatabase();
      return mydb;
    } else {
      return mydb;
    }
  }

  int Version = 1;
  initiatedatabase() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'mydatabase22.db');
    Database mydatabase1 = await openDatabase(
      databasepath,
      version: Version,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE IF NOT EXISTS 'TABLE1'(
      'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      'name' TEXT NOT NULL,
      'mobile' TEXT NOT NULL,
      'email' TEXT NOT NULL,
      'password' TEXT NOT NULL)
       ''');
        print("Database has been created");
      },
    );
    return mydatabase1;
  }

  checking() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'mydatabase22.db');
    await databaseExists(databasepath) ? print("it exists") : print("hardluck");
  }

  reseting() async {
    String databasedestination = await getDatabasesPath();
    String databasepath = join(databasedestination, 'mydatabase22.db');
    await deleteDatabase(databasepath);
  }



   reading(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawQuery(sql);
    return response;
  }

  writing(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawInsert(sql);
    return response;
  }

  deleting(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawDelete(sql);
    return response;
  }

  updating(sql) async {
    Database? somevariable = await mydbcheck();
    var response = somevariable!.rawUpdate(sql);
    return response;
  }
}
