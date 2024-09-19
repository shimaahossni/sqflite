import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Custom_widget/button_style.dart';
import 'Custom_widget/custom_textfield.dart';
import 'database/SqlHelper.dart';
import 'database/nodesModel.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {


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
    Size mediaquery=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/entry.png",height: mediaquery.height*.5,fit: BoxFit.cover,),
              Positioned(
                top: mediaquery.height*.2,
                  left: mediaquery.height*.1,
                  child: Container(
                    //color: Colors.green,
                    height: 50,
                    width: mediaquery.width*.65,
                    child:   CustomTextField(
                      controller: title,
                      name: "title",
                      hint: 'Title',
                      inputType: TextInputType.text,
                    )

                  )),
              Positioned(
                  top: mediaquery.height*.27,
                  left: mediaquery.height*.1,
                  child: Container(
                    //color: Colors.green,
                      height: 50,
                      width: mediaquery.width*.65,
                      child:   CustomTextField(
                        controller: content,
                        name: "content",
                        hint: 'content',
                        inputType: TextInputType.text,
                      )

                  )),
              Positioned(
                  top: mediaquery.height*.35,
                  left: mediaquery.height*.18,
                  child: Container(
                    //color: Colors.green,
                      height: 50,
                      width: mediaquery.width*.25,
                      child:   ElevatedButton(
                        style: buttonPrimary,
                        onPressed: () {
                          addNotes();
                        },
                          child: Text("Save",style: TextStyle(
                              fontSize: mediaquery.height*.02,
                              color: Colors.white
                          ),)
                      )

                  ),),
            ],
          ),
          Expanded(
            child:GridView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: mediaquery.height*.1,
                        width: mediaquery.width*.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(note[index].title,style: TextStyle(fontSize: 22),),
                          subtitle: Text(note[index].content,style: TextStyle(fontSize: 18),),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              delete(note[index].id!);
                            },
                          ),
                        ),
                      ),
                    ),


                    SizedBox(height: 10,),
                  ],
                );
              },
              itemCount:note.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            ),
          ),
        ],
      ),
    );
  }
}
