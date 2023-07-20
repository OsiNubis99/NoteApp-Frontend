// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/presentation/providers/user_provider.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../note/noteEditor_screen.dart';
import '../ocr-no-try-left/ocrNoTryLeft_screen.dart';

class ResultScreen extends StatefulWidget {
  final String? path;

  ResultScreen({super.key, this.path, required this.idNota});

  String idNota;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _userProvider = UserProvider();
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    if(_userProvider.getId()!='2'){
      final route = MaterialPageRoute(
        builder: (context) => const NoTryLeftOCRScreen(),
      );
      Navigator.pushReplacement(context, route);
    }
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
                      idNote: widget.idNota, newBody: controller.text));
              Navigator.pushReplacement(context, route);
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
