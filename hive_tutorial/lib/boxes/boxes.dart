import 'package:hive/hive.dart';

import '../model/notes_model.dart';

class Boxes{
  // creating a getData() function and providing it the name defined in the main function
  static Box<NotesModel> getData() => Hive.box<NotesModel>('expense');
}