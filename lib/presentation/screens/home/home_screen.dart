

import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../note/noteList_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarMenu(context),
      body: Center(child: FilledButton.tonal(
      onPressed: (){
         final route = MaterialPageRoute(builder:(context) =>  const NoteListScreen());
         Navigator.pushReplacement(context, route); 
      },
      child: const Text('Lista de Notas'))
      ,),
    );
  }
}