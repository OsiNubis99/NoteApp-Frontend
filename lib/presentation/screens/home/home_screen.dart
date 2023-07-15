import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/menu_cards.dart';
import '../../widgets/home/menu_item.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/ocrcam/modal_optioncam.dart';
import '../../widgets/shared/sidebar_menu.dart';
import '../note/noteEditor_screen.dart';
import '../note/noteList_screen.dart';
import '../ocr-audio/ocrAudio_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:                       AppBarMenu(context),
      drawer:                       const SideBar(),
      body:                         const SafeArea(child: BodyContent()) ,
      floatingActionButton:         const CreateNoteFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,      
    );
  }
}

class BodyContent extends StatelessWidget {
  const BodyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 10) ,  
      child:      
        Column( 
          mainAxisSize: MainAxisSize.min,
          children: 
         [
           const SizedBox(
            height: 10,
          ),
          //const Text('Explora el poder de la',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w300,fontSize: 32)),
         // const Text('Inteligencia Artificial',textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 32,)),
          
          GradientText(
    'Explora                   ',
    style: const TextStyle(
        fontSize: 46.0,
    ),
    colors: const [
             Color.fromARGB(255, 255, 148, 17),
             Color.fromARGB(255, 255, 216, 21),
             Color.fromARGB(255, 255, 181, 21),
             Color.fromARGB(255, 222, 126, 1),
    ],
),
          const SizedBox(
            height: 20,
          ),

          Row( 
             crossAxisAlignment: CrossAxisAlignment.center,
            children:  [ 
               Expanded(
                child: 
                HomeItem(title: 'Lista de Notas     ',    bodyText: 'Cree, edite o elimine sus notas', color: AppTheme.note_1, icon: Icons.edit_note,               onPressed: () {final route = MaterialPageRoute(builder: (context) => const NoteListScreen());  Navigator.pushReplacement(context, route); },),     
              ),
                Container(
                  width: 10,
                ),

                Expanded(
                child: 
                HomeItem(title: 'Redactor de audio     ',    bodyText: '¡Convierta un audio en texto!', color: AppTheme.note_1, icon: Icons.edit_note,               onPressed: () {final route = MaterialPageRoute(builder: (context) => const OcrAudioScreen());  Navigator.pushReplacement(context, route); },),   
              ),
           
           
          ], ),


          const SizedBox(
            height: 10,
          ),
         
           HomeItem(title: 'Lector de imagenes     ',    bodyText: '¡Convierta una imagen en texto!', color: AppTheme.note_1, icon: Icons.edit_note,               onPressed: () { optionOcrCam(context); },),  

          const SizedBox(
            height: 30,
          ),  
              
          
          const Text('Tu última nota                                                     ' , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,)),

           const SizedBox(
            height: 10,
          ),  

            HomeItem(title: 'Lista de Notas     ',    bodyText: 'Cree, edite o elimine sus notas', color: AppTheme.note_1, icon: Icons.edit_note,               onPressed: () {final route = MaterialPageRoute(builder: (context) => const NoteListScreen());  Navigator.pushReplacement(context, route); },),      
           
        ],
    )
    );
  }
}




