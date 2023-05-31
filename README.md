# Notes App

The Notes App is a mobile application that allows users to create, view, and manage their personal notes. It provides a user-friendly interface for adding, editing, and deleting notes, and supports synchronization of notes across multiple devices using both Firestore and SQLite databases.

## Features

- Create new notes with a title, content, and date.
- Edit existing notes to update the title and content.
- Delete notes to remove them from the app.
- Synchronize notes across devices using Firestore and SQLite databases.
- Customize notes with different colors.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/notes-app.git
   
2. Navigate to the project directory:
   cd notes-app
   
3.Install the dependencies:
  flutter pub get

4.Run the app:
  flutter run
  
Technologies Used

* Flutter: A cross-platform framework for building mobile applications.
* Dart: The programming language used in Flutter development.
* Cloud Firestore: A NoSQL document database for storing and syncing data in real time.
* SQLite: A self-contained, serverless, and zero-configuration database engine used for local data storage.

Dependencies

* cloud_firestore: ^2.5.3
* sqflite: ^2.0.0+3
* path: ^2.1.0
* uuid: ^3.0.4

Directory Structure

* lib/: Contains the main source code of the application.
* model/: Defines the data models used in the app.
* style/: Contains the styling and theme configuration.
* db.dart: Provides the database provider class for SQLite operations.
* main.dart: The entry point of the application.
* note_editor_screen.dart: Screen for adding and editing notes.
* note_list_screen.dart: Screen for displaying a list of notes.



