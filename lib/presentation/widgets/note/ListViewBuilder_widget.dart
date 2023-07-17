import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/note/userNote_widget.dart';

import '../../../config/theme/app_theme.dart';
import '../../providers/note/note_provider.dart';

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
    return userNote(note: noteProvider.notes[index], color: AppTheme.colorTheme[index]);
  }
}