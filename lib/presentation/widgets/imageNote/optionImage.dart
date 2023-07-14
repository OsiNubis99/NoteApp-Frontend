import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/presentation/screens/ocrcam/resultext_screen.dart';

import '../ocrcam/image_cropper.dart';
import 'imageNote_widget.dart';

void optionAddImage(BuildContext context){
  showModalBottomSheet(
    context:context, 
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(top: 35, bottom: 25, right: 20,left: 20),
        height: 220,
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                final imagen = await addImage(source: ImageSource.gallery);
              },
              child: const OptionImageCard(title: "Cámara"),
            ),
            const SizedBox(height:15),
            MaterialButton(
              onPressed: () async {
                final imagen = await addImage(source: ImageSource.gallery);
              },
              child: const OptionImageCard(title: "Galería"),
            ),
          ],
        ),
      );
    },
  );
}

class OptionImageCard extends StatelessWidget {
  final String title;

  const OptionImageCard({
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