import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import '../../widgets/shared/appBarMenu.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const SideBar(),
    appBar: AppBarMenu(context),
    body: Container(
      padding: const EdgeInsets.all(30),
      child: Text(text),
    ),
  );
}