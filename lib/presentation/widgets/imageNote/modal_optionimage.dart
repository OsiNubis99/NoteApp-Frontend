  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class OptionImageCard extends StatelessWidget {
  final String title;

  const OptionImageCard({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(color: AppTheme.primary,),
          child: Column(
              children: <Widget>[
                Text(
                  title, 
                  textAlign: TextAlign.start,
                  style: AppTheme.lightTheme.textTheme.displaySmall,
                ),
              ],
          ),
        )
    );
  }
}