import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'nodesModel.dart';

class Sqlhelper{
  Database? database;
  getDatabase()async{
    if(database!=null){
      return database;
    }else{
      database=await initalDB();
      return database;
    }
  }

  initalDB()async{
    String databasepath=await getDatabasesPath();
    String path=join(databasepath,'notes.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (db,version)async{
          Batch batch=db.batch();
          batch.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
          ''');
          batch.commit();
        }
    );
  }

  insertNote(Notes note)async{
    Database db=await getDatabase();
    Batch batch=db.batch();
    batch.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    batch.commit();
  }

  loadNotes()async{
    Database db=await getDatabase();
    List<Map> maps=await db.query('notes');
    return List.generate(
        maps.length,
            (index) {
          return Notes(
            id: maps[index]['id'],
            title: maps[index]['title'],
            content: maps[index]['content'],
          );
        });
  }

  updateNote(Notes note)async{
    Database db=await getDatabase();
    await db.update(
      'notes',
      note.toMap(),
      where: 'id=?',
      whereArgs: [note.id],
    );
  }

  deleteNote(int id)async{
    Database db=await getDatabase();
    await db.delete(
      'notes',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}

