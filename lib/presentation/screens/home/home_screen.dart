import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/last_note.dart';
import '../../widgets/home/menu_options.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/shared/sidebar_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBarMenu(context),
      drawer: const SideBar(),
      body: const SafeArea(child: BodyContent()),
      floatingActionButton: const CreateNoteFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Body Content

class BodyContent extends StatelessWidget {
  const BodyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgGray,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuOptionsWidget(),
          LastNoteWidget(),
        ],
      ),
    );
  }
}
