import 'package:flutter/material.dart';
import 'package:note_app_frontend/domain/entities/note.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';
import 'package:note_app_frontend/presentation/screens/note/noteEditor_screen.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../config/theme/app_theme.dart';
import '../../providers/note/local_note_provider.dart';
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

     final _noteProvider = context.watch<LocalNoteProvider>();


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
              padding: const EdgeInsets.only(left:15,right: 5,top: 0,bottom: 0),
              child: Column(children: <Widget>[

                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){sendNoteToTrash(note,_noteProvider,context);}, icon: const  Icon(Icons.close),)
                 ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                       Align(
                      alignment: Alignment.topLeft,
                      child: Text(note.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),

                    SizedBox(
                      height: 100,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(note.description)),
                    ),

                  ],


                ),

                 
               
              ]
              ),
            )),
      ),
    );
  }

  void sendNoteToTrash(Note note,LocalNoteProvider noteProvide,BuildContext context){
   note.status="inactive";
   noteProvide.editNote(note, note.id);
    final route = MaterialPageRoute(
    builder: (context) => const NoteListScreen());
     Navigator.pushReplacement(context, route);
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
