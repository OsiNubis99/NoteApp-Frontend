import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/shared/alertSnackBar.dart';
import '../note/noteEditor_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class TagScreen extends StatefulWidget {

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  late TextEditingController  tagcontroller;
  String nameTag = '';
  
  @override
  void initState(){
    super.initState();

    tagcontroller = TextEditingController();
  }

  @override
  void dispose(){
    tagcontroller.dispose();

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
            final route = MaterialPageRoute(builder: (context) => NoteEditorScreen());
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
            final route = MaterialPageRoute(builder: (context) => NoteEditorScreen());
              Navigator.pushReplacement(context, route);
          },
          ),
        ],
      ),

      body: SafeArea(

        //NEW TAG
        child: Container(
          padding: const EdgeInsets.only(top: 10, right:5, left:5, bottom: 10),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppTheme.primary.withOpacity(0.10)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.primary.withOpacity(0.25),
                          AppTheme.primary.withOpacity(0.25),
                        ]
                      ),
                    ),
                    child: Text(
                      "Etiqueta agregada", 
                      style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 148, 148, 148),)
                    ),
                  ),
                ],
              ),

              //add tag buttom
              GestureDetector( 
                onTap: () { 
                  final nameTag = newTagDialog(); 

                  if (nameTag == null) return;

                  setState(() => this.nameTag = nameTag as String);

                },
                child: const ListTile(
                  title: Text(
                    'Nueva etiqueta',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.text_dark,),
                  ),
                  leading: Icon(Icons.new_label,),
                ),
              ),

              //lista de etiquetas ya guardadas
              const ListTile(
                  title: Text(
                    'Etiquetas anteriores',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.text_dark,),
                  ),
                  leading: Icon(Icons.label,),
                ),
              const Text(
                'Lista de etiquetas guardadas anteriormente',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 148, 148, 148),),
              ),

            ],
          ),
        ),

      ),
    );
  }

  newTagDialog(){
    showDialog(context: context, builder: (context){
      return StatefulBuilder(
        builder: ((context, setState) {
          return AlertDialog(
            title: Text("Nueva etiqueta", style: AppTheme.lightTheme.textTheme.titleLarge,),
            icon: const Icon(Icons.new_label), iconColor: AppTheme.text_dark,
            backgroundColor: AppTheme.bgGray,
            surfaceTintColor: AppTheme.bgGray,
            content: TextField(
              controller: tagcontroller,
              onSubmitted: (_) => addTag(),
              decoration: const InputDecoration(
                hintText: 'Nombre de etiqueta',
                hintStyle: TextStyle(color: Color(0x3B000000),),
              ),
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
          );
        })
      );
    });
  }

  void addTag(){
    Navigator.of(context).pop(tagcontroller.text);

    tagcontroller.clear();
    
    SnackBar snackBar = AlertSnackBar(titulo: "¡Etiqueta creada!", mensaje: "Tu nueva etiqueta a sido creada con éxito", tipo: ContentType.success);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  
}
