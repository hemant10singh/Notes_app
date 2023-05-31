import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/db.dart';
import 'package:notes_app/screens/note_editor.dart';
import 'package:notes_app/screens/note_reader.dart';
import 'package:notes_app/style/app_style.dart';
import 'package:notes_app/widgets/notes_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   getNotes() async {
    final notes = await DatabaseProvider.db.getNotes(); //get notes
    return notes;
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Firebase Notes"),
        centerTitle: true,
        backgroundColor: Appstyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your recent Notes",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            
                 Expanded(   
                    child: StreamBuilder<QuerySnapshot>(        //streambuilder is a widget to check the real time changes in databases.
                      stream: FirebaseFirestore.instance.collection("notes").snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                        //cheking the connection state,if we still loadthe date we can display a progress
                        if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(snapshot.hasData)
                        {
                  //         final notes = snapshot.data!.docs.map((doc) {
                  //        return Note(
                  //     id: doc.id,
                  //     notes_title: doc["notes_title"],
                  //     notes_content: doc["notes_content"],     //changes
                  //     creation_date: doc["creation_date"],
                  //     color_id: doc["color_id"],
                  //   );
                  // }).toList();
                           
                          return GridView(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          children: snapshot.data!.docs.map((note) => noteCard((){            //use of notecard        // note is in the noteeditor
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteReaderScreen(note)));  //notereader
                          }, note)).toList(),    //to pass the data to the list
                          );
                        }
                  return Text(
                    "There's no text",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteEditorScreen())); //noteeditor
        },
        label: Text("Add note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
