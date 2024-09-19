import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database/SqlHelper.dart';
import 'database/nodesModel.dart';
class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  TextEditingController title=TextEditingController();
  TextEditingController content=TextEditingController();
  List<Notes> note=[];

  loudNote()async{
    final data=await Sqlhelper().loadNotes();
    setState(() {
      note=data;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loudNote();
  }

  //insert data
  addNotes()async{
    Notes note=Notes(title: title.text, content: content.text);
    await Sqlhelper().insertNote(note);
    title.clear();
    content.clear();
    loudNote();
  }

  delete(int id)async{
    Sqlhelper().deleteNote(id);
    loudNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 40,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'title'
                ),
              ),
              TextField(
                controller: content,
                decoration: InputDecoration(
                  hintText: 'content'
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  addNotes();
                },
                child: Text('Save'),
              ),


              Expanded(
                child: ListView.builder(
                  itemCount: note.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(note[index].title),
                        subtitle: Text(note[index].content),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (){
                            delete(note[index].id!);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
