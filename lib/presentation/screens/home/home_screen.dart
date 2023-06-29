import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';
import 'package:note_app_frontend/presentation/screens/ocr-audio/ocrAudio_screen.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/menu_cards.dart';
import '../../widgets/ocrcam/modal_optioncam.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../note/noteEditor_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.bgGray,
      drawer: const SideBar(),
      appBar: AppBarMenu(context),
      body: 
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: Column(
                    children: const [
                      Align(
                        alignment: Alignment.center,
                        child: Text('Opciones de Menú',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                      ),
                      
                      Text('El poder de la I.A. en tus manos'),
                      SizedBox(height: 20,),
                
                
                      MenuOptions(),
                    ],
                  ),
                ),
              )
           ,
       floatingActionButton: 
         
          FloatingActionButton(
            heroTag: "Create",
            shape: const StadiumBorder(),
            backgroundColor: AppTheme.primary,
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => NoteEditorScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
            child: const Icon(Icons.add,color: AppTheme.text_dark),
          ),


       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MenuOptions extends StatelessWidget {
  const MenuOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 

GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  childAspectRatio: 1.15,
                  crossAxisSpacing: 0,
                  mainAxisSpacing:  20,
                  children:   [
                     MenuItem( title: 'Lista de Notas     ',    bodyText: 'Cree, edite o elimine sus notas', color: AppTheme.note_1, icon: Icons.edit_note,               onPressed: () {final route = MaterialPageRoute(builder: (context) => const NoteListScreen());  Navigator.pushReplacement(context, route); },),
                     MenuItem( title: 'Lector de imagenes  ',bodyText: '¡Convierta una imagen en texto!', color: AppTheme.note_2, icon: Icons.photo_camera,               onPressed: () {final route = MaterialPageRoute(builder: (context) => const NoteListScreen());  Navigator.pushReplacement(context, route); },),
                     MenuItem( title: 'Redactor de audio   ', bodyText: '¡Convierta un audio en texto!',   color: AppTheme.note_3, icon: Icons.multitrack_audio_outlined, onPressed: () {final route = MaterialPageRoute(builder: (context) => const NoteListScreen());  Navigator.pushReplacement(context, route); },),
                    
                    ]
                  );

      // Text('Opciones de Menú',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
  }
}

class MenuItem extends StatelessWidget {
  
  final VoidCallback onPressed;
  final String title;
  final IconData   icon;
  final Color  color;
  final String bodyText;
  
  
  const MenuItem({
    super.key, required this.title, required this.icon, required this.color, required this.bodyText, required this.onPressed,
  });

  

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,

      child:  OptionCard(
        title: title, 
        theme: color,
        icono: icon,
        body: bodyText
      ),
    );
  }
}
