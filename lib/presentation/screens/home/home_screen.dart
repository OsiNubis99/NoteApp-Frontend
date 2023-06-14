import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/menu_cards.dart';
import '../../widgets/shared/appBarMenu.dart';

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
      body: Stack (
          children: <Widget>[
            SafeArea(
              child: GridView.count(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 5),
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 32,
                  children: <Widget>[ 

                      //NOTAS
                      MaterialButton(
                        onPressed: () {
                          final route = MaterialPageRoute(builder: (context) => const NoteListScreen());
                          Navigator.pushReplacement(context, route);
                        },

                        child: const OptionCard(
                          title: "Notas                         ", 
                          theme: AppTheme.note_1,
                          icono: Icons.edit_note,
                          body: "Cree, edite o elimine sus notas"
                        ),
                      ),


                      //OCRCAM
                      MaterialButton(
                        onPressed: () {
/*                           final route = MaterialPageRoute(builder: (context) => const Screen());
                          Navigator.pushReplacement(context, route); */
                        },

                        child: const OptionCard(
                          title: "Lector de imagenes", 
                          theme: AppTheme.note_2,
                          icono: Icons.camera_alt_rounded,
                          body: "¡Convierta una imagen en texto!"
                        ),
                      ),


                      //AUDIO CAPTURE
                      MaterialButton(
                        onPressed: () {
/*                           final route = MaterialPageRoute(builder: (context) => const Screen());
                          Navigator.pushReplacement(context, route); */
                        },

                        child: const OptionCard(
                          title: "Redactor de audio    ", 
                          theme: AppTheme.note_3,
                          icono: Icons.multitrack_audio_outlined,
                          body: "¡Convierta un audio en texto!"
                        ),
                      ),


                  ],
              )
            )
          ]
      )
    );
  }
}