import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_tutorial/boxes/boxes.dart';
import 'package:hive_tutorial/model/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  var total=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
      ),

      // now it will automatically refreshes the UI without calling setState
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          // wrapping the data into list so it can be dealt with easily
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                data[index].title.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.deepPurple),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: (){
                                  update(data[index], data[index].title,data[index].description);
                                },
                                  child: const Icon(Icons.edit)),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: (){
                                  delete(data[index]);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data[index].description.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Add notes')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText: 'Enter item', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Enter price', border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    var box = Boxes.getData();
                    box.add(data);
                    data.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          );
        }
        );
  }

  void delete(NotesModel notesModel)async{
    await notesModel.delete();
}

  void update(NotesModel notesModel,String title,description)async {
    titleController.text = title;
    descriptionController.text=description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Add notes')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText: 'Enter item', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Enter price', border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    notesModel.title = titleController.text.toString();
                    notesModel.description= descriptionController.text.toString();
                    notesModel.save();
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();

                  },
                  child: const Text('Edit')),
            ],
          );
        });

  }
}
