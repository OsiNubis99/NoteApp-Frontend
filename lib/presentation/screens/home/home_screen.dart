

import 'package:flutter/material.dart';
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
                  padding: EdgeInsets.only(top: 60.0, left: 25, right: 25, bottom: 20),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 40,
                    children: const <Widget>[ 

                      //NOTAS
                      OptionCard(title: "Notas                         ", theme: AppTheme.note_1,),

                      //OCRCAM
                      OptionCard(title: "Lector de imagenes", theme: AppTheme.note_2,),


                      //AUDIO CAPTURE
                      OptionCard(title: "Transcripción de audio", theme: AppTheme.note_3,),


                    ],
                ),
          )]
      )
    );
  }
}



class OptionCard extends StatelessWidget {
  //final String imagen o icono
  final String title;
  final Color theme;
  //final Function onPressed;
  
  const OptionCard({
    super.key, 
    required this.title, required this.theme, //required this.onPressed,
    //required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0, left: 20, right: 20, bottom: 70),
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
                Spacer(),
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