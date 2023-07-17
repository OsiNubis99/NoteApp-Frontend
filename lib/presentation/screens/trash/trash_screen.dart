import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../providers/note/note_provider.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/note/noteGridBuilder_widget.dart';
import '../../widgets/note/userNote_widget.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../../widgets/shared/sidebar_menu.dart';


class TrashScreen extends StatefulWidget {
  const TrashScreen({super.key});

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      appBar:                       AppBarMenu(context),
      drawer:                       const SideBar(),
      body:                         const SafeArea(child: BodyContentWidget()),
      floatingActionButton:         const CreateNoteFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,      
    );
  }
}

class BodyContentWidget extends StatelessWidget {
  const BodyContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final noteProvider = context.watch<NoteProvider>();
    //final countNote = noteProvider.notes.length;
    final countNoteInactive = noteProvider.notesInactive.length;
    noteProvider.getNotes();

    return  (countNoteInactive != 0) ?  TrashNoteItemsWidget(countNoteInactive: countNoteInactive, noteProvider :noteProvider ) : const EmptyTrashWidget() ;
    
    
  }
}

class EmptyTrashWidget extends StatelessWidget {
  const EmptyTrashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No hay basura'));
  }
}

class TrashNoteItemsWidget extends StatelessWidget {
  const TrashNoteItemsWidget({
    super.key,
    required this.countNoteInactive,
    required this.noteProvider,
  });

  final int countNoteInactive;
  final NoteProvider noteProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: 
              GridView.count(
        crossAxisCount: 2,
        children: List.generate(countNoteInactive, (index) {
          return Center(
              child:
               userNote(note: noteProvider.notesInactive[index], color: AppTheme.colorTheme[index])
        
        );
        }))
              
              );
  }
}