import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';

import '../widgets/shared/appBarMenu.dart';
import '../widgets/shared/sidebar_menu.dart';
  
  @override
  Widget imageScreen(BuildContext context, File? imagen) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          imagen!= null
          ? Image.file(imagen)
          : Container(
            margin: EdgeInsets.all(5),
            height: 200,
            color: AppTheme.primary,
          )
        ],

      )
    );
  }