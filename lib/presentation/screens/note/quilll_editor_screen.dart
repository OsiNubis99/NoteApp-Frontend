import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';
import 'package:note_app_frontend/presentation/screens/note/noteEditor_screen.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:uuid/uuid.dart';

class QuillEditorScreen extends StatefulWidget {
  QuillEditorScreen({Body? body, this.idNote = ''}) {
    if (body == null) {
      currentBody = Body(
        id: '',
        idNota: idNote,
        date: DateTime.now(),
        image: {},
        text: '',
      );
    } else {
      currentBody = body;
    }
  }
  String idNote;
  late Body currentBody;

  @override
  State<QuillEditorScreen> createState() => _QuillEditorScreenState();
}

class _QuillEditorScreenState extends State<QuillEditorScreen> {
  late QuillEditorController controller;
  final _noteProvider = LocalNoteProvider();

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Architects Daughter');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black12, fontWeight: FontWeight.normal);

  bool _hasFocus = false;

  _saveData(context) async {
    widget.currentBody.text = await controller.getText();
    if (widget.currentBody.id == '') {
      _noteProvider.addNoteBody(widget.idNote, widget.currentBody);
    } else {
      _noteProvider.editNoteBody(widget.idNote, widget.currentBody);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Contenido guardado con exito!'),
      ),
    );
  }

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route = MaterialPageRoute(
                builder: (context) => NoteEditorScreen(
                      idNote: widget.idNote,
                    ));
            Navigator.pushReplacement(context, route);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
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
            onPressed: () async => _saveData(context),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: ToolBar.scroll(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 25,
              iconColor: _toolbarIconColor,
              activeIconColor: Colors.greenAccent.shade400,
              controller: controller,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.vertical,
              customButtons: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: _hasFocus ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(15)),
                ),
                InkWell(
                    onTap: () => unFocusEditor(),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.black,
                    )),
                InkWell(
                    onTap: () async {
                      var selectedText = await controller.getSelectedText();
                      debugPrint('selectedText $selectedText');
                      var selectedHtmlText =
                          await controller.getSelectedHtmlText();
                      debugPrint('selectedHtmlText $selectedHtmlText');
                    },
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: QuillHtmlEditor(
              text: widget.currentBody.text,
              hintText: 'Agrega contenido a la nota',
              controller: controller,
              isEnabled: true,
              minHeight: 200,
              textStyle: _editorTextStyle,
              hintTextStyle: _hintTextStyle,
              hintTextAlign: TextAlign.start,
              padding: const EdgeInsets.only(left: 10, top: 10),
              hintTextPadding: const EdgeInsets.only(left: 20),
              backgroundColor: _backgroundColor,
              onFocusChanged: (focus) {
                debugPrint('has focus $focus');
                setState(() {
                  _hasFocus = focus;
                });
              },
              onTextChanged: (text) => debugPrint('widget text change $text'),
              onEditorCreated: () {
                debugPrint('Editor has been loaded');
              },
              onEditorResized: (height) => debugPrint('Editor resized $height'),
              onSelectionChanged: (sel) =>
                  debugPrint('index ${sel.index}, range ${sel.length}'),
            ),
          ),
        ],
      ),
    );
  }

  Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();
}
