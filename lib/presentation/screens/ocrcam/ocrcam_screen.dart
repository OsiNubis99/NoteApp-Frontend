import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:note_app_frontend/presentation/screens/ocrcam/resultext_screen.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

import '../../widgets/shared/appBarMenu.dart';


class OcrCamScreen extends StatefulWidget {
  const OcrCamScreen({super.key});

  @override
  State<OcrCamScreen> createState() => _OcrCamScreenState();
}

class _OcrCamScreenState extends State<OcrCamScreen> with WidgetsBindingObserver{
  bool isPermissionGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  final _textRecognizer = TextRecognizer();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = requestCameraPermission();
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    stopCamera();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if (_cameraController == null || !_cameraController!.value.isInitialized){
      return;
    }

    if (state == AppLifecycleState.inactive){
      stopCamera();
    } else if (state == AppLifecycleState.resumed && _cameraController != null && _cameraController!.value.isInitialized){
      startCamera();
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (isPermissionGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    initCameraController(snapshot.data!);
                    return Center(child: CameraPreview(_cameraController!));
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
              Scaffold(
                drawer: const SideBar(),
                appBar: AppBarMenu(context),
                backgroundColor: isPermissionGranted ? Colors.transparent : null,
                body: isPermissionGranted 

                  // PERMISSION ACEPTED
                  ? Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: (){scanPicture;},
                            child: const Text("Scan text"),
                          ),
                        ),
                      )
                    ],
                  )

                  // PERMISSION DENIED
                  : Center(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: const Text(
                            'Permiso de cámara negado',
                            textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
              )
          ],
        );
      },
    );
  }


  //CAMERA PERMISSION
  Future<void> requestCameraPermission() async{
    final status = await Permission.camera.request();
    isPermissionGranted = status == PermissionStatus.granted;
  }

  //CAMERA ACTIONS
  void startCamera(){
    if (_cameraController != null){
      cameraSelected(_cameraController!.description);
    }
  }

  void stopCamera(){
    if (_cameraController != null){
      _cameraController?.dispose();
    }
  }


  //OPEN BACK CAMERA
  void initCameraController(List<CameraDescription> cameras){
    if (_cameraController != null){
      return;
    }

    CameraDescription? camera;
    for (var i=0; i<cameras.length; i++){
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back){
        camera = current;
        break;
      }
    }

    if (camera != null){
      cameraSelected(camera);
    }
  }

  Future<void> cameraSelected(CameraDescription camera) async{
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _cameraController?.initialize();

    if(!mounted){
      return;
    }
    setState(() {});
  }

  //SCAN PICTURE
  Future<void> scanPicture() async {
    if (_cameraController == null) return;

    final navigator = Navigator.of(context);

    try{
      final pictureFile = await _cameraController!.takePicture();

      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder:(context) => ResultScreen(text: recognizedText.text),
        )
      );
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text ("Ocurrió un error al escanear el texto")
        )
      );
    }
  }

}