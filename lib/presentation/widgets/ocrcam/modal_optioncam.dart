import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/presentation/screens/ocrcam/resultext_screen.dart';

import 'image_picker_widget.dart';
import 'image_cropper.dart';

void optionOcrCam(BuildContext context){
  showModalBottomSheet(
    context:context, 
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(top: 35, bottom: 25, right: 20,left: 20),
        height: 220,
        child: Column(
          children: [
            MaterialButton(
              onPressed: (){
                pickImage(source: ImageSource.camera).then((value) {
                  if (value != ''){
                    imageCropper(value, context).then((value) {
                      if(value != ''){
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (_) => ResultScreen(path: value,)
                        ));
                    }
                  });}
                });
              },
              child: const OptionOCRCard(title: "Cámara"),
            ),
            const SizedBox(height:15),
            MaterialButton(
              onPressed: (){
                pickImage(source: ImageSource.gallery).then((value) {
                  if (value != ''){
                    imageCropper(value, context).then((value) {
                      if(value != ''){
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (_) => ResultScreen(path: value,)
                        ));
                    }
                  });}
                });
              },
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