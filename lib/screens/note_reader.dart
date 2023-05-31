import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/style/app_style.dart';

import '../db.dart';

class NoteReaderScreen extends StatefulWidget {
   NoteReaderScreen(this.doc,{super.key});
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}
 
class _NoteReaderScreenState extends State<NoteReaderScreen> {

  Future<void> deleteNote() async {
    try {
      final String id = widget.doc.id;

      // Delete from Firestore
      await FirebaseFirestore.instance.collection('notes').doc(id).delete();
      print('Note deleted from Firestore successfully');

      // Delete from SQLite
      await DatabaseProvider.db.deleteNoteById(id);
      print('Note deleted from SQLite successfully');

      Navigator.pop(context);
    } catch (err) {
      // Handle any error that occurred while deleting
      print('Error deleting note: $err');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    int color_id=widget.doc['color_id'];
    return Scaffold(
            backgroundColor: Appstyle.cardsColor[color_id],
            appBar: AppBar(
              backgroundColor: Appstyle.cardsColor[color_id],
              elevation: 0.0,
               actions: [
          IconButton( icon:Icon(Icons.delete),
          onPressed: deleteNote,
                 )
        ],
            ),
            body: Padding
            (
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.doc["notes_title"],style: Appstyle.mainTitle,), SizedBox(height: 4.0,),
                    Text(widget.doc["creation_date"].toString(),style: Appstyle.dateTitle,),SizedBox(height:28.0),
                    Text(widget.doc["notes_content"],style: Appstyle.mainContent,),
                   ],
                ),
            ),
    );
  }
}























