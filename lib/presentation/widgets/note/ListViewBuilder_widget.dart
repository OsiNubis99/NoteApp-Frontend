import 'package:flutter/cupertino.dart';
import 'package:note_app_frontend/presentation/widgets/note/userNote_widget.dart';

import '../../../config/theme/app_theme.dart';
import '../../providers/note/local_note_provider.dart';

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({
    super.key,
    required this.noteProvider,
    required this.index,
  });

  final LocalNoteProvider noteProvider;
  final int index;

  final colorNotes = [
    AppTheme.note_1,
    AppTheme.note_2,
    AppTheme.note_3,
    AppTheme.note_4,
    AppTheme.note_5
  ];

  @override
  Widget build(BuildContext context) {
    return userNote(
      note: noteProvider.localNotes[index],
      color: colorNotes[index % 5],
      index: index,
    );
  }
}
