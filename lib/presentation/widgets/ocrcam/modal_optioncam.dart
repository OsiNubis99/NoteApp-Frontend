import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';

import '../../screens/ocrcam/ocrcam_screen.dart';

void optionOcrCam(BuildContext context){
  showModalBottomSheet(
    context:context, 
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: 220,
        child: Column(
          children: [
            MaterialButton(
              onPressed: (){
                final route = MaterialPageRoute(builder: (context) => const OcrCamScreen());
                Navigator.pushReplacement(context, route);
              },
              child: const OptionOCRCard(title: "Cámara"),
            ),
            const SizedBox(height:15),
            MaterialButton(
              onPressed: (){},
              child: const OptionOCRCard(title: "Galería"),
            ),
          ],
        ),
      );
    },
  );
}

class OptionOCRCard extends StatelessWidget {
  final String title;

  const OptionOCRCard({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(color: AppTheme.primary,),
          child: Column(
              children: <Widget>[
                Text(
                  title, 
                  textAlign: TextAlign.start,
                  style: AppTheme.lightTheme.textTheme.displaySmall,
                ),
              ],
          ),
        )
    );
  }
}