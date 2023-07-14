import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/note/noteList_screen.dart';
import 'package:note_app_frontend/presentation/screens/ocr-audio/ocrAudio_screen.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/home/menu_cards.dart';
import '../../widgets/ocrcam/modal_optioncam.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../note/noteEditor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      drawer: const SideBar(),
      appBar: AppBarMenu(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            children: const [
              // Primera sección : Menu de opciones
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Opciones de Menú',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              Text('El poder de la I.A. en tus manos'),
              SizedBox(
                height: 20,
              ),

              MenuOptions(),

              // Primera sección : Últimas 3 notas
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Últimas Notas',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              Text('Continua el trabajo donde lo dejaste'),
              SizedBox(
                height: 20,
              ),

              LastNotes(),

              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Create",
        shape: const StadiumBorder(),
        backgroundColor: AppTheme.primary,
        onPressed: () {
          final route = MaterialPageRoute(
            builder: (context) => NoteEditorScreen(),
          );
          Navigator.pushReplacement(context, route);
        },
        child: const Icon(Icons.add, color: AppTheme.text_dark),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class LastNotes extends StatelessWidget {
  const LastNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        //padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return const NoteItem();
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              thickness: 5,
            ),
        itemCount: 2);
  }
}

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: MaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Fecha Nota',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 10),
              ),
              Text(
                'Titulo Nota',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent a massa at sapien.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'Etiqueta',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, color: AppTheme.note_3),
              ),
            ],
          ),
        ));
  }
}

class MenuOptions extends StatelessWidget {
  const MenuOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        childAspectRatio: 1.30,
        crossAxisSpacing: 0,
        mainAxisSpacing: 20,
        children: [
          MenuItem(
            title: 'Lista de Notas     ',
            bodyText: 'Cree, edite o elimine sus notas',
            color: AppTheme.note_1,
            icon: Icons.edit_note,
            onPressed: () {
              final route = MaterialPageRoute(
                  builder: (context) => const NoteListScreen());
              Navigator.pushReplacement(context, route);
            },
          ),
          MenuItem(
            title: 'Lector de imagenes  ',
            bodyText: '¡Convierta una imagen en texto!',
            color: AppTheme.note_2,
            icon: Icons.photo_camera,
            onPressed: () {
              optionOcrCam(context);
            },
          ),
          MenuItem(
            title: 'Redactor de audio   ',
            bodyText: '¡Convierta un audio en texto!',
            color: AppTheme.note_3,
            icon: Icons.multitrack_audio_outlined,
            onPressed: () {
              final route = MaterialPageRoute(
                  builder: (context) => const OcrAudioScreen());
              Navigator.pushReplacement(context, route);
            },
          ),
        ]);

    // Text('Opciones de Menú',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
  }
}

class MenuItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final Color color;
  final String bodyText;

  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.bodyText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child:
          OptionCard(title: title, theme: color, icono: icon, body: bodyText),
    );
  }
}
