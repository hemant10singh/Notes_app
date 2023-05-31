import "dart:math";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:notes_app/db.dart";
import "package:notes_app/model/note.dart";
import "package:notes_app/style/app_style.dart";
import "package:uuid/uuid.dart";

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});
 

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
 
  
  int color_id = Random().nextInt(Appstyle.cardsColor.length);
  String date = DateTime.now().toString();

  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _maincontroller = TextEditingController();

  Future<void> addNoteToFirestore(Note note) async {
    await FirebaseFirestore.instance.collection('notes').add({
      'notes_title': note.notes_title,
      'creation_date': note.creation_date,
      'notes_content': note.notes_content,
      'color_id': note.color_id,
    });
    print('Note added to Firestore successfully');
  }

  Future<void> addNoteToSQLite(Note note) async {
    // db=await DatabaseProvider.getNotes();
    await DatabaseProvider.db.addNewNote(note);
    print('Note added to SQLite successfully');
  }



  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titlecontroller,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Note Title'),
            style: Appstyle.mainTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            style: Appstyle.dateTitle,
          ),
          SizedBox(
            height: 28.0,
          ),
          TextField(
            controller: _maincontroller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Note Content'),
            style: Appstyle.mainContent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor: Appstyle.accentColor,
  onPressed: () async {
    try {
      String id = Uuid().v4();
      Note note = Note(
        id: id,
        notes_title: _titlecontroller.text,
        notes_content: _maincontroller.text,
        creation_date: date,
        color_id: color_id,
      );
      await addNoteToFirestore(note);
      await addNoteToSQLite(note); 
     
      // Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
       Navigator.pop(context);
    } catch (err) {
      // Handle any error that occurred while saving
      print('Error saving note: $err');
    }
  },
  child: Icon(Icons.save),
),
    );
  }
}













