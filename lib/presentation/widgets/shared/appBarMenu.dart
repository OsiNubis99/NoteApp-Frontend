import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/trash/trash_screen.dart';
import '../../../config/theme/app_theme.dart';
import '../../screens/ocr-no-try-left/ocrNoTryLeft_screen.dart';


AppBar AppBarMenu(BuildContext context) {
  return AppBar(
      backgroundColor: AppTheme.bgGray,
      elevation: 0,
      title: Image.asset(
        "assets/my_notes_app.png",
        width: 130,
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppTheme.text_dark),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete, color: AppTheme.text_dark),
          onPressed: () {
           
           final route = MaterialPageRoute(
             builder: (context) => const TrashScreen(),
           );
           Navigator.pushReplacement(context, route);

          },
        ),
         IconButton(
          icon: const Icon(Icons.hourglass_empty, color: AppTheme.text_dark),
          onPressed: () {
           final route = MaterialPageRoute(
             builder: (context) => const NoTryLeftOCRScreen(),
           );
           Navigator.pushReplacement(context, route);
        })
      ],
      
    );
}
