import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initializing the app
  await Firebase.initializeApp();
  await DatabaseProvider.db.initDB();
 
  runApp(const MyApp());
}

//first of all create new firebase project
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,  
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",

      
      routes: {"/":(context)=>HomeScreen(),
      },
      // home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes app"),
      ),
      body: Container(),
    );
  }
}
