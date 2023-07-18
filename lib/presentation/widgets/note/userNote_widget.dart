import 'package:flutter/material.dart';
import 'package:note_app_frontend/domain/entities/note.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';
import 'package:note_app_frontend/presentation/screens/note/noteEditor_screen.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../config/theme/app_theme.dart';
import '../../providers/note/note_provider.dart';

class userNote extends StatelessWidget {
  final QuillEditorController _quillController = QuillEditorController();
  final Note note;
  final int index;
  final Color color;

  userNote({
    super.key,
    required this.color,
    required this.index,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        final route = MaterialPageRoute(
            builder: (context) => NoteEditorScreen(
                  idNote: note.id,
                ));
        Navigator.pushReplacement(context, route);
      },
      child: Card(
        color: color,
        child: SizedBox(
            width: 200,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                       Align(
                      alignment: Alignment.centerLeft,
                      child: Text(note.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),

                    SizedBox(
                      height: 60,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(note.description)),
                    ),

                  ],
                ),
              ]),
            )),
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
      onPressed: () {
        final route =
            MaterialPageRoute(builder: (context) => const HomeScreen());
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
