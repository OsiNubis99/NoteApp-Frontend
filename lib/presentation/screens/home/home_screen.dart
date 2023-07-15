import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/last_note.dart';

import '../../widgets/home/menu_item.dart';
import '../../widgets/home/menu_options.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/ocrcam/modal_optioncam.dart';
import '../../widgets/shared/sidebar_menu.dart';

import '../note/noteList_screen.dart';
import '../ocr-audio/ocrAudio_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:            AppTheme.white,
      appBar:                       AppBarMenu(context),
      drawer:                       const SideBar(),
      body:                         const SafeArea(child: BodyContent()) ,
      floatingActionButton:         const CreateNoteFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,      
    );
  }
}

class BodyContent extends StatelessWidget {
  const BodyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  
          Container(
            color: AppTheme.bgGray,
            child: Column( 
              mainAxisSize: MainAxisSize.min,
              
              children: 
             const [
               MenuOptionsWidget(), 
               LastNoteWidget(),
            ],
                ),
          );
  }
}






