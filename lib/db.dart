import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/note.dart';

class DatabaseProvider{

  DatabaseProvider._();
  static final DatabaseProvider db=DatabaseProvider._();
  static Database? _database;

Future<Database> get database async {
  if (_database != null) {
    return _database!;
  }
  _database = await initDB();
  return _database!;
}

initDB() async {
  return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
      onCreate: (db, version) async {
    await db.execute(''' 
       CREATE TABLE notes(
        id TEXT PRIMARY KEY,
        notes_title TEXT,
        notes_content TEXT,
        creation_date TEXT,
        color_id INT
       )
       ''');
  }, version: 1);
}



Future<String> addNewNote(Note note) async {
    final db = await database;
    final id = note.id; // Use the provided ID instead of generating a new one
    await db.insert(
      "notes",
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }
Future<dynamic>getNotes()async{
  final db=await database;
  var res =await db.query("notes");
  if(res.length==0){
    return null;
  }
  else {
    var resultMap=res.toList();
    return resultMap.isNotEmpty? resultMap: Null;
  }
}

Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      "notes",
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

Future<void> deleteNoteById(String id) async {
  final db = await database;
  await db.delete("notes", where: "id = ?", whereArgs: [id]);
}

}

