import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../screens/note/noteEditor_screen.dart';

class CreateNoteFAB extends StatelessWidget {
  const CreateNoteFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
         heroTag: "Create",
         shape: const StadiumBorder(),
         backgroundColor: AppTheme.primary,
         onPressed: () {
           final route = MaterialPageRoute(
             builder: (context) => NoteEditorScreen(),
           );
           Navigator.pushReplacement(context, route);
         },
         child: const Icon(Icons.add,color: AppTheme.text_dark),
       );
  }
}