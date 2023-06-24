import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import '../../widgets/shared/appBarMenu.dart';

class ResultScreen extends StatefulWidget {
  final String? path;
  const ResultScreen({Key? key,this.path}) :super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState(){
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBarMenu(context),
      body: _isBusy == true
      ? const Center(
        child: CircularProgressIndicator(),
      ) : Container(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          maxLines: MediaQuery.of(context).size.height.toInt(),
          controller: controller,
        )
      )
    );
  }

  void processImage(InputImage image) async {

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);


    setState(() {
      _isBusy = true;
    });

    final RecognizedText recognizedText = await textRecognizer.processImage(image);

    controller.text = recognizedText.text;


    setState(() {
      _isBusy = false;
    });
  }

}

