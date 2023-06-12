

import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../../../config/theme/app_theme.dart';
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
                  padding: EdgeInsets.only(top: 60.0, left: 15, right: 15, bottom: 20),
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 40,
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
                        ),
                      ),


                      //OCRCAM
                      MaterialButton(
                        onPressed: () {
                          final route = MaterialPageRoute(builder: (context) => const NoteListScreen());
                          Navigator.pushReplacement(context, route);
                        },

                        child: const OptionCard(
                          title: "Lector de imagenes", 
                          theme: AppTheme.note_2,
                        ),
                      ),


                      //AUDIO CAPTURE
                      MaterialButton(
                        onPressed: () {
                          final route = MaterialPageRoute(builder: (context) => const NoteListScreen());
                          Navigator.pushReplacement(context, route);
                        },

                        child: const OptionCard(
                          title: "Transcripción de audio", 
                          theme: AppTheme.note_3,
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



class OptionCard extends StatelessWidget {
  //final String icon;
  final String title;
  final Color theme;
  
  const OptionCard({
    super.key, 
    required this.title, 
    required this.theme,
    //required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, left: 15, right: 15, bottom: 60),
        decoration: BoxDecoration(
        color: theme,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(
          offset: Offset(5, 5),
          blurRadius: 10,
          spreadRadius: -9,
          color: AppTheme.text_dark
        )]
      ),
            child: Column(
              children: <Widget>[
                const Spacer(),
                //icono
                //Spacer(),
                Text(
                  title, 
                  textAlign: TextAlign.start,
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                )
              ],
      )
    );
  }
}