import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/models/body_model.dart';
import '../../../infrastructure/models/note_model.dart';
import '../../providers/note/note_provider.dart';
import '../note/noteEditor_screen.dart';
import '../note/noteList_screen.dart';
import '../note/quilll_editor_screen.dart';

class ResultScreen extends StatefulWidget {
  final String? path;

  ResultScreen({Key? key, this.path, required String idNota}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  late String idNota;
  late String idBody;
  late Body contentOCR;

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        title: Image.asset(
          "assets/my_notes_app.png",
          width: 130,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.text_dark),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.text_dark),
            onPressed: () {
              final route = MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(
                      idNote: idNota, newBody: controller.text));
              Navigator.pushReplacement(context, route);
              controller.text = '';
            },
          ),
        ],
      ),
      body: _isBusy == true
          ? const Center(
              child: CircularProgressIndicator(),
            )

          //SCAN TEXT
          : Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                maxLines: MediaQuery.of(context).size.height.toInt(),
                controller: controller,
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
            ),
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller.text = recognizedText.text;

    setState(() {
      _isBusy = false;
    });
  }
}
