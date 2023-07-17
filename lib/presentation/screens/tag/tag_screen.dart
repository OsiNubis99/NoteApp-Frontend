import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../../widgets/shared/sidebar_menu.dart';
import '../note/noteEditor_screen.dart';
import 'new_tag_screen.dart';

class TagScreen extends StatefulWidget {

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route =
              MaterialPageRoute(builder: (context) => NoteEditorScreen());
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
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.text_dark),
              onPressed: () async {},
          ),
        ],
      ),

      body: SafeArea(

        //NEW TAG
        child: Container(
          padding: const EdgeInsets.only(top: 20, right:5, left:5, bottom: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  final route = MaterialPageRoute(builder: (context) => NewTagScreen());
                  Navigator.push(context, route);
                },
                child: const ListTile(
                  title: Text(
                    'Nueva etiqueta',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: AppTheme.text_dark,),
                  ),
                  leading: Icon(Icons.new_label),
                ),
              ),
            ],
          ),
        ),

        //lista de etiquetas ya guardadas
      ),
    );
  }

}