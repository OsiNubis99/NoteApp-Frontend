import 'package:flutter/material.dart';
import '../../../config/theme/app_theme.dart';

AppBar AppBarMenuBack(BuildContext context) {
  return AppBar(
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
          icon: const Icon(Icons.search, color: AppTheme.text_dark),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buscar Proximamente')));
          },
        ),
      ],
      
    );
}
