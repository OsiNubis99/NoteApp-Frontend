
import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';

import '../../../config/theme/app_theme.dart';



class userNote extends StatelessWidget {
  
  final String title;
  final String body;
  final Color color;
  
  const userNote({
    super.key, required this.title, required this.body, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        child:  SizedBox(
            width: 200,
            height: 200,
            
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  
                  Column(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(body),
                          ),
                    ],
                  ),
                 
                 
                     
                ]
                ),
            )


        ),
      );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: (){
        final route = MaterialPageRoute(builder: (context) => const HomeScreen());
        Navigator.pushReplacement(context, route);
      },
      style: IconButton.styleFrom(
        foregroundColor: AppTheme.note_1,
        backgroundColor: AppTheme.note_2,
        disabledBackgroundColor: AppTheme.note_3,
        hoverColor: AppTheme.note_1,
        focusColor: AppTheme.note_4,
        highlightColor: AppTheme.note_5,
      ),
    );
  }
}
