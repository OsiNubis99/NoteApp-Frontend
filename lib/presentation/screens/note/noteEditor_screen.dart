import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/infrastructure/models/note_model.dart';
import 'package:note_app_frontend/infrastructure/models/task_model.dart';
import 'package:note_app_frontend/presentation/providers/note/local_note_provider.dart';
import 'package:note_app_frontend/presentation/screens/note/quilll_editor_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/geolocator/geolocator_widget.dart';
import '../../widgets/ocrcam/modal_optioncam.dart';
import '../../widgets/shared/alertSnackBar.dart';
import '../ocr-audio/optionOcrAudio.dart';
import '../tag/tag_screen.dart';
import 'noteList_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  final _uuid = const Uuid();
  final _noteProvier = LocalNoteProvider();

  NoteEditorScreen({super.key, String idNote = '', Body? newBody}) {
    if (idNote == '') {
      idNote = 'offline_${_uuid.v4()}';
      _noteProvier.addNote(Note(
          id: idNote,
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
    currentNote = _noteProvier.getNote(idNote);

    if (newBody != null) {
      currentNote.body.add(newBody);
    }
  }

  late Note currentNote;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen>
    with SingleTickerProviderStateMixin {
  late HtmlParser htmlParser;
  String address = 'Ubicación';
  late num lat;
  late num long;

  final _uuid = const Uuid();
  int _tabSelected = 0;
  final dateNow = DateTime.now().toString();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskTextController = TextEditingController();
  final ScrollController _taskScrollController = ScrollController();
  final List<Widget> _bubbles = [];

  _initData() async {
    final ntP = LocalNoteProvider();
    ntP.getNotes();
    _titleController.text = widget.currentNote.title;
    _descriptionController.text = widget.currentNote.description;

    for (var e in widget.currentNote.body) {
      _bubbles.add(InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuillEditorScreen(
                  idNote: widget.currentNote.id,
                  body: e,
                ),
              ),
            );
          },
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black54),
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(5),
            //     bottomLeft: Radius.circular(5),
            //   ),
            // ),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Html(
              data: e.text,
            ),
          )));
    }

    setState(() {});
  }

  _saveData() async {
    widget.currentNote.title = _titleController.text;
    widget.currentNote.description = _descriptionController.text;
    widget.currentNote.date = dateNow;
    widget.currentNote.longitude = long;
    widget.currentNote.latitude = lat;
    widget.currentNote.address = address;
  }

  @override
  void initState() {
    determinePosition().then((value) async {
      await getAddress(value);
    });
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _noteProvider = context.watch<LocalNoteProvider>();
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      floatingActionButton: _tabSelected == 1
          ? Container(
              width: MediaQuery.of(context).size.width * 0.90,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey)
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _taskTextController,
                              decoration: const InputDecoration(
                                  hintText: "Escribe tu tarea",
                                  hintStyle: TextStyle(
                                      color: Colors.black26, fontSize: 20),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: AppTheme.primary, shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () {
                        final createdTask = Task(
                          id: 'offline_${_uuid.v4()}',
                          idNota: widget.currentNote.id,
                          status: false,
                          title: _taskTextController.text,
                          date: DateTime.now(),
                        );
                        _noteProvider.addNoteTask(
                            widget.currentNote.id, createdTask);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('¡Tarea guardada con exito!')));
                        _taskTextController.text = '';
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          : SpeedDial(
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
                  child: const Icon(Icons.edit),
                  backgroundColor: AppTheme.note_1,
                  foregroundColor: Colors.white,
                  label: 'Agregar Contenido',
                  labelStyle: const TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuillEditorScreen(
                          idNote: widget.currentNote.id,
                        ),
                      ),
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.camera),
                  backgroundColor: AppTheme.note_5,
                  foregroundColor: Colors.white,
                  label: 'Agregar Imagen',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => print('SECOND CHILD'),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.image),
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.note_2,
                  label: 'Imagen a Texto',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => print('THIRD CHILD'),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.mic),
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.note_3,
                  label: 'Voz a Texto',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => optionOcrAudio(context,_noteProvider,widget.currentNote.id),
                ),

                //add more menu item childs here
              ],
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
          icon: const Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        title: Image.asset(
          "assets/my_notes_app.png",
          width: 130,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.text_dark),
        actions: [
          //Tag
          /* 
          IconButton(
            icon: const Icon(
              Icons.sell_outlined,
              color: AppTheme.text_dark,
            ),
            onPressed: () async {
              final route =
                  MaterialPageRoute(builder: (context) => TagScreen());
              Navigator.pushReplacement(context, route);
            },
          ), */
          //Check
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.text_dark),
            onPressed: () async {
              _saveData();
              if (!widget.currentNote.id.startsWith('offline_')) {
                widget.currentNote.offlineStatus = OfflineStatus.edited;
              }
              _noteProvider.editNote(widget.currentNote, widget.currentNote.id);
              SnackBar snackBar = AlertSnackBar(
                  titulo: "¡Nota guardada!",
                  mensaje: "Nota guardada con éxito",
                  tipo: ContentType.success);

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              final route = MaterialPageRoute(
                  builder: (context) => const NoteListScreen());
              Navigator.pushReplacement(context, route);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ExpansionTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  focusNode: FocusNode(),
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Título',
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  minLines: 1,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _descriptionController,
                    minLines: 1,
                    maxLines: 3,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text("Fecha: ${dateNow.substring(0, 10)}",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.normal)),
                      ),

                      //UBICACION
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          address,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
            child: Row(
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
                      color:
                          _tabSelected == 0 ? AppTheme.primary : Colors.white,
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
                        color:
                            _tabSelected == 0 ? Colors.white : Colors.black54,
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
                      color:
                          _tabSelected == 1 ? AppTheme.primary : Colors.white,
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
                        color:
                            _tabSelected == 1 ? Colors.white : Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tabSelected == 0
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    width: MediaQuery.of(context).size.width - 10,
                    alignment: Alignment.center,
                    child: ListView(
                      children: _bubbles,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    padding: const EdgeInsets.only(bottom: 60),
                    width: MediaQuery.of(context).size.width - 10,
                    alignment: Alignment.center,
                    child: ListView(
                      controller: _taskScrollController,
                      children: widget.currentNote.tasks
                          .map((e) => TaskCard(e.status, e.title))
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  //GET ADDRESS
  Future<void> getAddress(Position value) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(value.latitude, value.longitude);

    Placemark place = placemarks[0];

    setState(() {
      address = "${place.locality}, ${place.country}";
    });
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
      margin: const EdgeInsets.symmetric(vertical: 5),
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
  }
}
