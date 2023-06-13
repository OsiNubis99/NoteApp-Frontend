import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';

class NoteListWidget extends StatelessWidget {
  const NoteListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children:  [
            Container(
              decoration: BoxDecoration(
                color: AppTheme.note_1,
                borderRadius: BorderRadius.circular(5)
              ),
              child: const Padding(
                padding:  EdgeInsets.all(8),
                child: Text('Contenido Nota')
                ),
            )
          ],
          
        )
      )
      );
  }
}