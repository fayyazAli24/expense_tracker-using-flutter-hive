import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/homeScreen.dart';
import 'package:hive_tutorial/model/notes_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //the data of the phone will be added in this variable called directory
  var directory = await getApplicationDocumentsDirectory();

  //now the directory is initialized in hive
  Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());

  // a file by the name of notes in created in the hive
  await Hive.openBox<NotesModel>('expense');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
