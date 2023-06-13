import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/note/noteList_widget.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';

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
    return Scaffold(
      appBar: AppBarMenu(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: 
          GridView.count(
          crossAxisCount: 2,
          children: const <Widget>[
              userNote(title: 'sdg', body: 'date', color: AppTheme.note_1),
              userNote(title: 'sdg', body: 'date', color: AppTheme.note_1),
              userNote(title: 'sdg', body: 'date', color: AppTheme.note_2),
              userNote(title: 'sdg', body: 'date', color: AppTheme.note_3),
              userNote(title: 'sdg', body: 'date', color: AppTheme.note_4),
          ],
          )
        )
        ),
    );
  }
}