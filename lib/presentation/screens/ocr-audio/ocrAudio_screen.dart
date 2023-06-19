import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';

class OcrAudioScreen extends StatefulWidget {
  const OcrAudioScreen({super.key});

  @override
  State<OcrAudioScreen> createState() => _OcrAudioScreenState();
}

class _OcrAudioScreenState extends State<OcrAudioScreen> {

  bool openCapture = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMenu(context),
      body:  SafeArea(child: 
      Center(child: (!openCapture) ? 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
           const SizedBox(height: 180),
          Image.asset("assets/audioCollector.png",width: 200,),
          const SizedBox(height: 20),
          const Text('Presiona Play',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          const SizedBox(height: 10),
          const Text('Para comenzar a recolectar texto por audio')
      ],)
      :
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
           const SizedBox(height: 180),
          Image.asset("assets/record_2.gif",width: 200,),
          const SizedBox(height: 20),
          const Text('Grabando...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),

      ],)
      
      )
      )
      ,
     floatingActionButton: ( !openCapture ) ? 
          fabButton(
          onPressed: (){
            openCapture = true;
            setState(() {});
          },
          tagName: "Play",   
          icon: Icons.play_arrow, 
           bgColor: AppTheme.primary,
         )
           :  
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             fabButton(
          onPressed: (){
           
          },
          tagName: "Pause",   
          icon: Icons.pause, 
          bgColor: AppTheme.note_1,
         ),
          fabButton(
          onPressed: (){
             openCapture = false;
             setState(() {});
          },
          tagName: "Stop",   
          icon: Icons.stop, 
           bgColor: Color.fromARGB(255, 255, 27, 27),
         ),
          fabButton(
          onPressed: (){
           
          },
          tagName: "Save",   
          icon: Icons.save, 
           bgColor: AppTheme.note_3,
         )
           
         ],)
         ,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
      
  }
}



class fabButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String tagName;
  final IconData icon;
  final Color bgColor;

  const fabButton({super.key, required this.onPressed, required this.tagName, required this.icon, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
          heroTag: tagName,
          onPressed: onPressed,
          shape: const StadiumBorder(),
          backgroundColor: bgColor,
          child: Icon(icon, color: AppTheme.text_dark),
          
          );
  }
}



