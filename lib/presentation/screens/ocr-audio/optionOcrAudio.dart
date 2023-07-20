import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../config/theme/app_theme.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../note/noteEditor_screen.dart';


void  optionOcrAudio(BuildContext context, LocalNoteProvider _noteProvider , String idNote){
  showModalBottomSheet(
    context:context, 
    builder: (context) {


     SpeechToText _speechToText = SpeechToText();
     bool _speechEnabled = false;
     String _words = '';
     Body body;
     DateTime date = DateTime.now();
     final idBody =  Uuid().toString();


    _initSpeech(_speechEnabled, _speechToText);
      return Container(
        padding: const EdgeInsets.only(top: 35, bottom: 25, right: 20,left: 20),
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('Para comenzar a recolectar texto por audio',style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),
            Text(_words),
            const SizedBox(height: 20),
             Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Container(
                  decoration: const ShapeDecoration(
                    color: AppTheme.note_2,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.play_arrow),
                    color: AppTheme.text_dark,
                    onPressed: () {
                      _startListening(_speechToText,_words);
                    },
                  ),
            ),

             Container(
              decoration: const ShapeDecoration(
                color: AppTheme.note_2,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.stop),
                color: AppTheme.text_dark,
                onPressed: () {
                  _stopListening(_speechToText);
                  body = Body(id: idBody, idNota: idNote, text: _words, image: {}, date: date, ocr: true);               
                  _noteProvider.addNoteBody(idNote,body);
                  final route = MaterialPageRoute(builder: (context) => NoteEditorScreen(idNote:idNote));
                  Navigator.pushReplacement(context, route);


                },
              ),
            ),
               ],
             ),
           
            
          ],
        ),
      );
    },
  );
}

/// This has to happen only once per app
  void _initSpeech(bool _speechEnabled, SpeechToText _speechToText) async {
    _speechEnabled = await _speechToText.initialize();
  }

  void _startListening(SpeechToText _speechToText, String _words) async {
    await _speechToText.listen(onResult: (SpeechRecognitionResult result){
       _words = result.recognizedWords;
    });
  }

  void _stopListening(SpeechToText _speechToText) async {
    await _speechToText.stop();
  }


