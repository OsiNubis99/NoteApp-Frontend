import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/tag/tag_screen.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/shared/sidebar_menu.dart';

class NewTagScreen extends StatefulWidget {

  @override
  State<NewTagScreen> createState() => _NewTagScreenState();
}

class _NewTagScreenState extends State<NewTagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      drawer: const SideBar(),
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route =
              MaterialPageRoute(builder: (context) => TagScreen());
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
              onPressed: () async {
            final route =
              MaterialPageRoute(builder: (context) => TagScreen());
              Navigator.pushReplacement(context, route);
          },
          ),
        ],
      ),

      body: SafeArea(

        //NEW TAG
        child:Container(
          padding: const EdgeInsets.all(20),
            child: TextFormField(
              maxLines: MediaQuery.of(context).size.height.toInt(),
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
        ),
      )
    );
  }

}