import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_frontend/config/helpers/location.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/domain/entities/note.dart';
import 'package:note_app_frontend/presentation/providers/note/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../widgets/imageNote/addimage_picker_widget.dart';
import '../image/imageTest_screen.dart';
import 'noteList_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen({NoteEntity? note}) {
    if (note == null) {
      currentNote = NoteEntity(
          idNota: '',
          tituloNota: '',
          descriptionNota: '',
          fechaNota: '',
          estadoNota: '');
    } else {
      currentNote = note;
    }
  }

  late NoteEntity currentNote;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen>
    with SingleTickerProviderStateMixin {
  late QuillEditorController _quillController;
  int _tabSelected = 0;

  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  final customToolBarList = [
    ToolBarStyle.align,
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.color,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.indentMinus,
    ToolBarStyle.indentAdd,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = AppTheme.lightTheme.colorScheme.background;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal);
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black26, fontWeight: FontWeight.normal);
  final dateNow = DateTime.now().toString();

  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  late TabController _tabController;
    final List<Map<String, dynamic>> _contentExamples = [
    {'id': 1, 'status': false, 'text': 'Task 1'},
    {'id': 2, 'status': true, 'text': 'Task 2'},
    {'id': 3, 'status': false, 'text': 'Task 3'},
    {'id': 4, 'status': true, 'text': 'Task 4'},
    {'id': 5, 'status': false, 'text': 'Task 5'},
    {'id': 6, 'status': false, 'text': 'Task 6'},
    {'id': 7, 'status': false, 'text': 'Task 7'},
    {'id': 8, 'status': false, 'text': 'Task 8'},
  ];
  final List<Map<String, dynamic>> _tasksExamples = [
    {'id': 1, 'status': false, 'text': 'Task 1'},
    {'id': 2, 'status': true, 'text': 'Task 2'},
    {'id': 3, 'status': false, 'text': 'Task 3'},
    {'id': 4, 'status': true, 'text': 'Task 4'},
    {'id': 5, 'status': false, 'text': 'Task 5'},
    {'id': 6, 'status': false, 'text': 'Task 6'},
    {'id': 7, 'status': false, 'text': 'Task 7'},
    {'id': 8, 'status': false, 'text': 'Task 8'},
  ];

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  _initData() async {
    _quillController
        .setText(widget.currentNote.descriptionNota)
        .then((value) => print("PROBANDO $value"));
    _titleController.text = widget.currentNote.tituloNota;
  }

  @override
  void initState() {
    _quillController = QuillEditorController();
    _quillController.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    print('LOCATION:');
    print(LocationService.getCurrentLocation());

    _tabController = TabController(length: 2, vsync: this);
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List <String> popList=["Cámara","Galería"];
    File? image_to_upload;

    final _noteProvider = context.watch<NoteProvider>();
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 40,
        child: Row(
          children: [
            SpeedDial(
              //Speed dial menu
              // marginBottom: 10,
              //margin bottom
              icon: Icons.menu,

              //icon on Floating action button
              activeIcon: Icons.close,
              //icon when menu is expanded on button
              backgroundColor: AppTheme.primary,
              //background color of button
              foregroundColor: Colors.white,
              //font color, icon color in button
              activeBackgroundColor: AppTheme.primary,
              //background color when menu is expanded
              activeForegroundColor: Colors.white,
              buttonSize: const Size(56, 56),
              //button size
              visible: true,
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'),
              // action when menu opens
              onClose: () => print('DIAL CLOSED'),
              //action when menu closes

              elevation: 8.0,
              //shadow elevation of button
              shape: CircleBorder(),
              //shape of button

              //OPTIONS MENU
              children: [
                SpeedDialChild(
                  child: Icon(Icons.accessibility),
                  backgroundColor: AppTheme.note_1,
                  foregroundColor: Colors.white,
                  label: 'First Menu Child',

                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => print('FIRST CHILD'),
                  onLongPress: () => print('FIRST CHILD LONG PRESS'),
                ),
                SpeedDialChild(
                  child: Icon(Icons.brush),
                  backgroundColor: AppTheme.note_5,
                  foregroundColor: Colors.white,
                  label: 'Second Menu Child',
                  labelStyle: TextStyle(fontSize: 18.0),
                  //onTap: () => print('SECOND CHILD'),
                  onTap: () {PopupOptions(image_to_upload, popList); //prueba para agregar imagen
                  } ,
                  onLongPress: () => print('SECOND CHILD LONG PRESS'),
                ),
                SpeedDialChild(
                  child: Icon(Icons.keyboard_voice),
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.note_3,
                  label: 'Third Menu Child',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => print('THIRD CHILD'),
                  onLongPress: () => print('THIRD CHILD LONG PRESS'),
                ),

                //add more menu item childs here
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Escribe tu tarea",
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 20),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: AppTheme.primary, shape: BoxShape.circle),
              child: InkWell(
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onLongPress: () {},
              ),
            )
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route =
              MaterialPageRoute(builder: (context) => const NoteListScreen());
              Navigator.pushReplacement(context, route);
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
              onPressed: () async {
                if( widget.currentNote.idNota =='') {
                  _noteProvider
                    .addNote(
                        title: _titleController.text,
                        description: await _quillController.getPlainText())
                    .then((e) {});
                } else {
                  widget.currentNote.tituloNota = _titleController.text;
                  widget.currentNote.descriptionNota = await _quillController.getPlainText();
                  _noteProvider
                      .updateNote(widget.currentNote)
                      .then((e) {});
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Nota guardada con exito!')));
              },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                ExpansionTile(
                    title: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                      child: TextField(
                        focusNode: FocusNode(),
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Título',
                          hintStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        minLines: 1,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 1),
                              child: Text("Fecha: ${dateNow.substring(0, 10)}"),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 1),
                              child: Text("Ubicación"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          children: [
                            QuillHtmlEditor(
                              hintText: 'Descripción',
                              controller: _quillController,
                              isEnabled: true,
                              minHeight: 120,
                              textStyle: _editorTextStyle,
                              hintTextStyle: _hintTextStyle,
                              hintTextAlign: TextAlign.start,
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              hintTextPadding: const EdgeInsets.only(left: 20),
                              onFocusChanged: (hasFocus) =>
                                  debugPrint('has focus $hasFocus'),
                              onTextChanged: (text) =>
                                  debugPrint('widget text change $text'),
                              onEditorCreated: () {
                                _quillController.setText(
                                    widget.currentNote.descriptionNota);
                                debugPrint('Editor has been loaded');
                              },
                              onEditorResized: (height) =>
                                  debugPrint('Editor resized $height'),
                              onSelectionChanged: (sel) => debugPrint(
                                  'index ${sel.index}, range ${sel.length}'),
                            ),
                            ToolBar.scroll(
                              toolBarColor: _toolbarColor,
                              padding: const EdgeInsets.all(8),
                              iconSize: 20,
                              iconColor: _toolbarIconColor,
                              controller: _quillController,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.horizontal,
                              toolBarConfig: customToolBarList,
                            ),
                          ],
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _tabSelected = 0;
                        });
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 5,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: _tabSelected == 0
                              ? AppTheme.primary
                              : Colors.white,
                          border: Border.all(
                              color: _tabSelected == 0
                                  ? Colors.transparent
                                  : Colors.black54),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Contenido',
                          style: TextStyle(
                            color: _tabSelected == 0
                                ? Colors.white
                                : Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _tabSelected = 1;
                        });
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 5,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: _tabSelected == 1
                              ? AppTheme.primary
                              : Colors.white,
                          border: Border.all(
                              color: _tabSelected == 1
                                  ? Colors.transparent
                                  : Colors.black54),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Tareas',
                          style: TextStyle(
                            color: _tabSelected == 1
                                ? Colors.white
                                : Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _tabSelected == 0
                ? Container(
                    margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Chat',
                      style: const TextStyle(fontSize: 50),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 600,
                    alignment: Alignment.center,
                    child: ListView(
                      children: _tasksExamples
                          .map((e) => TaskCard(e['status'], e['text']))
                          .toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

///////////////////////////////////////ADD IMAGE////////////////////////////////////////
  void PopupOptions(File? image_to_upload, List<String> popList) {
  showModalBottomSheet(
    context:context, 
    builder: (context) {
      return PopupMenuButton(
      onSelected: (title) async {
        if (title == "Cámara"){
          final imagen = await addImage(source: ImageSource.camera);
          setState(() {
            image_to_upload = File(imagen!.path);
          });
          final route = MaterialPageRoute(builder: (context) => imageScreen(context, image_to_upload));  Navigator.pushReplacement(context, route);
        }
        else if (title == "Galería"){
          final imagen = await addImage(source: ImageSource.gallery);
          setState(() {
            image_to_upload = File(imagen!.path);
          });
          final route = MaterialPageRoute(builder: (context) => imageScreen(context, image_to_upload));  Navigator.pushReplacement(context, route);
        }
      },
      itemBuilder: (context){
        return popList.map((e) => PopupMenuItem(
          value: e,
          child: Text(e, style: AppTheme.lightTheme.textTheme.displaySmall,),)).toList();
      },
      );
    }
  );}
////////////////////////////////////////////////////////////////////////////////////////
  

}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.only(left: 10),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}

class TaskCard extends StatefulWidget {
  TaskCard(this.status, this.description);

  bool status = false;
  String description;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Checkbox(
              value: widget.status,
              onChanged: (value) {
                setState(() {
                  widget.status = value!;
                });
              }),
          Expanded(flex: 5, child: Text(widget.description))
        ],
      ),
    );
    ;
  }
}
