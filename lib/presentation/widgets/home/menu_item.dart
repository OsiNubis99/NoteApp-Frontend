// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';

class HomeItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final Color color;
  final String bodyText;
  double height;

  HomeItem(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.icon,
      required this.color,
      required this.bodyText,
      this.height = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppTheme.white,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: const ShapeDecoration(
                        color: AppTheme.note_2,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(icon),
                        color: AppTheme.text_dark,
                        onPressed: () {},
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromARGB(255, 23, 23, 23))),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(bodyText,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 10)),
                ),
              ],
            ),
          ),
        ));
  }
}
