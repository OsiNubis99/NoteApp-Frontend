import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

AppBar AppBarMenu(BuildContext context) {
  return AppBar(
    backgroundColor: AppTheme.bgGray,
    elevation: 0,
    title: Image.asset(
      "assets/my_notes_app.png",
      width: 130,
    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppTheme.text_dark),
    actions: const [
      // IconButton(
      //   icon: const Icon(Icons.search, color: AppTheme.text_dark),
      //   onPressed: () {
      //       SnackBar snackBar = AlertSnackBar(titulo: "¡Próximamente!", mensaje: "La función de buscar estará disponible próximamente", tipo: ContentType.warning);
              
      //       ScaffoldMessenger.of(context)
      //         ..hideCurrentSnackBar()
      //         ..showSnackBar(snackBar);;
      //   },
      // ),
    ],
  );
}
