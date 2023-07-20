import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_theme.dart';
import '../../providers/note/local_note_provider.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/note/userNote_widget.dart';
import '../../widgets/shared/sidebar_menu.dart';
import '../note/noteList_screen.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({super.key});

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route = MaterialPageRoute(builder: (context) => NoteListScreen());
              Navigator.pushReplacement(context, route);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        title: Image.asset(
          "assets/my_notes_app.png",
          width: 130,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.text_dark),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.search, color: AppTheme.text_dark),
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text('Buscar Proximamente')));
          //   },
          // ),
        ],
      ),

      drawer: const SideBar(),
      body: const SafeArea(child: BodyContentWidget()),
      floatingActionButton: const CreateNoteFAB(),
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
    final noteProvider = context.watch<LocalNoteProvider>();
    noteProvider.getNotes();
    final notesInactive = noteProvider.getNotesInactive();
    final colorNotes = [
      AppTheme.note_1,
      AppTheme.note_2,
      AppTheme.note_3,
      AppTheme.note_4,
      AppTheme.note_5
    ];
    return (notesInactive.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(notesInactive.length, (index) {
                  return Center(
                      child: userNote(
                          note: notesInactive[index],
                          color: colorNotes[index % 5],
                          index: index));
                })))
        : const EmptyTrashWidget();
  }
}

class EmptyTrashWidget extends StatelessWidget {
  const EmptyTrashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/trash@4x.png",
          width: 320,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        const Text('No hay notas en la papelera',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 23, 23, 23))),
        const Text('Crear una nota en el boton de más'),
      ],
    ));
  }
}
