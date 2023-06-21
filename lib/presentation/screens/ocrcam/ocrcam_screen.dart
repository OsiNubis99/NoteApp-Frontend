import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

import '../../widgets/shared/appBarMenu.dart';
import '../../widgets/shared/sidebar_menu.dart';


class OrcCamScreen extends StatefulWidget {
  const OrcCamScreen({super.key});

  @override
  State<OrcCamScreen> createState() => _OrcCamScreenState();
}

class _OrcCamScreenState extends State<OrcCamScreen> with WidgetsBindingObserver{
  bool isPermissionGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = requestCameraPermission();
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if (_cameraController == null || !_cameraController!.value.isInitialized){
      return;
    }

    if (state == AppLifecycleState.inactive){
      _stopCamera();
    } else if (state == AppLifecycleState.resumed && _cameraController != null && _cameraController!.value.isInitialized){
      _startCamera();
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
                    _initCameraController(snapshot.data!);
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
                        child: const Center(
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text("Scan text"),
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

        /* return Scaffold(
          drawer: const SideBar(),
          appBar: AppBarMenu(context),
          body: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Text(
                isPermissionGranted
                  // PERMISSION GRANTED
                  ? 'Permiso de cámara aceptado'

                  // PERMISSION DENIED
                  : 'Permiso de cámara negado',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ); */
      },
    );
    
  }



//CAMERA PERMISSION
  Future<void> requestCameraPermission() async{
    final status = await Permission.camera.request();
    isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera(){
    if (_cameraController != null){
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera(){
    if (_cameraController != null){
      _cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras){
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
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async{
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

}