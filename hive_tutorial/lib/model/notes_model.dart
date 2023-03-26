// import 'package:build_runner/build_script_generate.dart';
import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)

// extending the notes model with hive object b/c it will automatically add data and updates the UI
class NotesModel extends HiveObject{
  @HiveField(0)
  String title='';
  @HiveField(1)
  String description='';
  NotesModel({required this.title,required this.description});


}