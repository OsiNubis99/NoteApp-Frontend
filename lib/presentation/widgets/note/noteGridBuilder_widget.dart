import 'package:flutter/material.dart';

import '../../providers/note/local_note_provider.dart';
import 'ListViewBuilder_widget.dart';

class NoteGridBuilderWidget extends StatelessWidget {
  const NoteGridBuilderWidget({
    super.key,
    required this.countNote,
    required this.noteProvider,
  });

  final int countNote;
  final LocalNoteProvider noteProvider;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(countNote, (index) {
          return Center(
              child: ListViewBuilder(noteProvider: noteProvider, index: index));
        }));
  }
}
