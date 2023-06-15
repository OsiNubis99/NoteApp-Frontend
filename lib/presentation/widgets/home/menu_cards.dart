import 'package:flutter/material.dart';
import '../../../config/theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  final IconData icono;
  final String title;
  final Color theme;
  final String body;
  
  const OptionCard({
    super.key, 
    required this.title, 
    required this.theme, required this.icono, required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 10, right: 15, bottom: 20),
        decoration: BoxDecoration(
        color: theme,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(
          offset: Offset(5, 5),
          blurRadius: 10,
          spreadRadius: -9,
          color: AppTheme.text_dark
        )]
      ),
            child: Column(
              children: <Widget>[
                Container (
                  alignment: Alignment.topLeft,
                  child: Icon(
                    icono,
                    size:35.0,
                    color: AppTheme.text_dark,
                  )
                ), const Spacer(),
                Text(
                  title, 
                  textAlign: TextAlign.start,
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ), const Spacer(),
                Text(
                  body, 
                  textAlign: TextAlign.start,
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),  const Spacer(),
              ],
      )
    );
  }
}
