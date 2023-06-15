import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/providers/note/note_provider.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/note/userNote_widget.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {

    final noteProvider = context.watch<NoteProvider>();

    final countNote = noteProvider.notes.length;

    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      drawer: const SideBar(),
      appBar: AppBarMenu(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: 
          (countNote != 0) ? 
          GridView.count(
          
          crossAxisCount: 2,
          children: 
          List.generate(countNote, (index) {
              return Center(
                child: 
                 ListViewBuilder(noteProvider: noteProvider,index:index) 
                
              );
            })
            
          )
          :
              Center(child: FilledButton.tonal(onPressed: (){},child: const Text('Crear una Nota')))
        )
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Update",
            onPressed: (){
              
              noteProvider.getNotes();
            },
            child: const Icon(Icons.update),
          ),
          const SizedBox(height: 10,)
           ,
           FloatingActionButton(
             heroTag: "Create",
             onPressed: (){
          
             },
             child: const Icon(Icons.add),
           ),
        ],
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
    required this.noteProvider,
    required this.index,
  });

  final NoteProvider noteProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return userNote(title: noteProvider.notes[index].tituloNota, body: noteProvider.notes[index].cuerpoNotaText, color: AppTheme.note_1);
    
  }
}