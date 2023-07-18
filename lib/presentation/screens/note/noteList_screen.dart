import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';
import 'package:note_app_frontend/presentation/screens/note/noteEditor_screen.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/note/ListViewBuilder_widget.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../trash/trash_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    final _noteProvider = context.watch<LocalNoteProvider>();
    _noteProvider.getNotes();
    final countNote = _noteProvider.localNotes.length;

    //  @override
    //   void setState(fn) {
    //     if(mounted) {
    //       super.setState(fn);
    //       if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
    //         SchedulerBinding.instance.addPostFrameCallback((_) =>  noteProvider.getNotes()); }

    //     }
    //   }

    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      drawer: const SideBar(),

      appBar: AppBar(
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
            icon: const Icon(Icons.search, color: AppTheme.text_dark),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buscar Proximamente')));
            },
          ),
        ],
      ),

      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(countNote, (index) {
                    return Center(
                        child: ListViewBuilder(
                            noteProvider: _noteProvider, index: index));
                  })))),
      
              floatingActionButton:         const CreateNoteFAB(),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,  
          );}
  }
