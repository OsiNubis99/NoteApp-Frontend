import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';
import '../../../infrastructure/enumns/offline_status.dart';
import '../../../infrastructure/models/body_model.dart';
import '../../../infrastructure/models/note_model.dart';
import '../../providers/note/local_note_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../note/noteEditor_screen.dart';
import '../ocr-no-try-left/ocrNoTryLeft_screen.dart';

class OcrAudioScreen extends StatefulWidget {
  OcrAudioScreen({super.key, this.idNote = ''});

  late final String idNote;

  @override
  State<OcrAudioScreen> createState() => _OcrAudioScreenState();
}

class _OcrAudioScreenState extends State<OcrAudioScreen> {
  final _userProvider = UserProvider();
  bool openCapture = false;

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _uuid = const Uuid();
    final _noteProvier = LocalNoteProvider();
    if (_userProvider.getId() != '2') {
      final route = MaterialPageRoute(
        builder: (context) => const NoTryLeftOCRScreen(),
      );
      Navigator.pushReplacement(context, route);
    }
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBarMenu(context),
      body: SafeArea(
          child: Center(
              child: (!openCapture)
                  ? (_lastWords == "")
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 180),
                            Image.asset(
                              "assets/audioCollector.png",
                              width: 200,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Presiona el microfono',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                                'Para comenzar a recolectar texto por audio'),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 320),
                            Container(
                              padding: EdgeInsets.all(8),
                              color: AppTheme.primary,
                              child: Text(_lastWords),
                            ),
                            const SizedBox(height: 20),
                            FilledButton(
                                onPressed: () {
                                  var id = widget.idNote;
                                  if (id == '') {
                                    id = 'offline_${_uuid.v4()}';
                                    _noteProvier.addNote(Note(
                                        id: id,
                                        title: 'Nueva Nota',
                                        description: '',
                                        date: DateTime.now().toString(),
                                        status: 'active',
                                        latitude: 0,
                                        longitude: 0,
                                        address: '',
                                        tasks: [],
                                        body: [],
                                        offlineStatus: OfflineStatus.created));
                                  }
                                  _noteProvier.addNoteBody(
                                      id,
                                      Body(
                                          id: '',
                                          idNota: widget.idNote,
                                          date: DateTime.now(),
                                          image: {},
                                          text: '<p>$_lastWords</p>',
                                          ocr: false));
                                  final route = MaterialPageRoute(
                                    builder: (context) => NoteEditorScreen(
                                      idNote: id,
                                    ),
                                  );
                                  Navigator.pushReplacement(context, route);
                                  setState(() {});
                                },
                                child: const Text('Guardar Nota')),
                          ],
                        )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 180),
                        Image.asset(
                          "assets/record_2.gif",
                          width: 200,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Grabando...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          // If listening is active show the recognized words
                          _speechToText.isListening
                              ? _lastWords
                              // If listening isn't active but could be tell the user
                              // how to start it, otherwise indicate that speech
                              // recognition is not yet ready or not supported on
                              // the target device
                              : _speechEnabled
                                  ? 'Precione pausa o stop para detener el microfono...'
                                  : 'El microfono no esta habilitado',
                        ),
                      ],
                    ))),
      floatingActionButton: (!openCapture)
          ? FabButton(
              tagName: "Play",
              onPressed: () {
                _startListening();
                openCapture = true;
                setState(() {});
              },
              icon: _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
              bgColor: AppTheme.primary,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FabButton(
                  tagName: "Stop",
                  onPressed: () {
                    openCapture = false;
                    setState(() {});
                  },
                  icon: Icons.stop,
                  bgColor: Color.fromARGB(255, 255, 27, 27),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class FabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String tagName;
  final IconData icon;
  final Color bgColor;

  const FabButton(
      {super.key,
      required this.onPressed,
      required this.tagName,
      required this.icon,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: tagName,
      onPressed: onPressed,
      shape: const StadiumBorder(),
      backgroundColor: bgColor,
      child: Icon(icon, color: AppTheme.text_dark),
    );
  }
}
