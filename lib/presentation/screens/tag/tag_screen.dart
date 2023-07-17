import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../note/noteEditor_screen.dart';

class TagScreen extends StatefulWidget {

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  late TextEditingController  controller;
  String tagName = '';
  
  @override
  void initState(){
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,

      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route =
              MaterialPageRoute(builder: (context) => NoteEditorScreen());
              Navigator.pushReplacement(context, route);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        title: Image.asset(
          "assets/my_notes_app.png",
          width: 130,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.text_dark),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.text_dark),
              onPressed: () async {
            final route =
              MaterialPageRoute(builder: (context) => NoteEditorScreen());
              Navigator.pushReplacement(context, route);
          },
          ),
        ],
      ),

      body: SafeArea(

        //NEW TAG
        child: Container(
          padding: const EdgeInsets.only(top: 20, right:5, left:5, bottom: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () { final tagName = newTagDialog(); 
                  setState(() => this.tagName = tagName as String);
                },
                child: const ListTile(
                  title: Text(
                    'Nueva etiqueta',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.text_dark,),
                  ),
                  leading: Icon(Icons.new_label),
                ),
              ),
            ],
          ),
        ),

        //lista de etiquetas ya guardadas
      ),
    );
  }

  Future<String?> newTagDialog() => showDialog <String>(
    context: context, builder: (context) =>  AlertDialog(
      title: Text("Nueva etiqueta", style: AppTheme.lightTheme.textTheme.titleLarge,),
      icon: Icon(Icons.new_label), iconColor: AppTheme.text_dark,
      backgroundColor: AppTheme.bgGray,
      surfaceTintColor: AppTheme.bgGray,
      content: TextField(
        decoration: InputDecoration(
          hintText: 'Nombre de etiqueta',
          hintStyle: TextStyle(color: Color(0x3B000000),),
        ),
        controller: controller,
        onSubmitted: (_) => addTag(),
      ),
      actions: [
        TextButton(
          onPressed: (){
              Navigator.of(context).pop();}, 
          child: Text("Cancelar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFFEDC123),),)
        ),
        TextButton(
          onPressed: addTag, 
          child: Text("Agregar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFFEDC123),)),
        )
      ],
    ),
  );

  void addTag(){
    Navigator.of(context).pop(controller.text);

    controller.clear();
  }
  
}
