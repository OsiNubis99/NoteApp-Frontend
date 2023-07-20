import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/widgets/shared/appBarMenu.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/last_note.dart';
import '../../widgets/home/menu_free_options.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/shared/sidebar_menu.dart';

class HomeFreeScreen extends StatefulWidget {
  const HomeFreeScreen({super.key});

  @override
  State<HomeFreeScreen> createState() => _HomeFreeScreenState();
}

class _HomeFreeScreenState extends State<HomeFreeScreen> {
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
      child: ListView(
        children: const [
          MenuFreeOptionsWidget(),
          LastNoteWidget(),
        ],
      ),
    );
  }
}
