import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app_frontend/config/helpers/location.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import 'package:material_tag_editor/tag_editor.dart';

import 'noteList_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen>
    with SingleTickerProviderStateMixin {
  late QuillEditorController _controller;
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
      fontSize: 18, color: Colors.black12, fontWeight: FontWeight.normal);
  final dateNow = DateTime.now().toString();

  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  late TabController _tabController;
  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  @override
  void initState() {
    _controller = QuillEditorController();
    _controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    print('LOCATION:');
    print(LocationService.getCurrentLocation());

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor, leading: IconButton(
          onPressed: () {
                          final route = MaterialPageRoute(builder: (context) => const NoteListScreen());
                          Navigator.pushReplacement(context, route);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                print(await _controller.getText());
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              child: TextField(
                focusNode: FocusNode(),
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 40,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text("Fecha: ${dateNow.substring(0, 10)}"),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: const Text("Ubicacion"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TagEditor(
                length: _values.length,
                controller: _textEditingController,
                focusNode: _focusNode,
                delimiters: const [',', ' '],
                hasAddButton: true,
                resetTextOnSubmitted: true,
                // This is set to grey just to illustrate the `textStyle` prop
                textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                onSubmitted: (outstandingValue) {
                  setState(() {
                    _values.add(outstandingValue);
                  });
                },
                inputDecoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add tag',
                ),
                onTagChanged: (newValue) {
                  setState(() {
                    _values.add(newValue);
                  });
                },
                tagBuilder: (context, index) => _Chip(
                  index: index,
                  label: _values[index],
                  onDeleted: _onDelete,
                ),
                // InputFormatters example, this disallow \ and /
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  QuillHtmlEditor(
                    hintText: 'Descripcion',
                    controller: _controller,
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
                      debugPrint('Editor has been loaded');
                    },
                    onEditorResized: (height) =>
                        debugPrint('Editor resized $height'),
                    onSelectionChanged: (sel) =>
                        debugPrint('index ${sel.index}, range ${sel.length}'),
                  ),
                  ToolBar.scroll(
                    toolBarColor: _toolbarColor,
                    padding: const EdgeInsets.all(8),
                    iconSize: 20,
                    iconColor: _toolbarIconColor,
                    controller: _controller,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    direction: Axis.horizontal,
                    toolBarConfig: customToolBarList,
                  ),
                ],
              ),
            ),
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
                      color: _tabSelected == 0 ? AppTheme.note_1 : Colors.white,
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
                      'Chat',
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
                      color: _tabSelected == 1 ? AppTheme.note_1 : Colors.white,
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
            Container(
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
                _tabSelected == 0 ? 'Chat' : 'Tareas',
                style: const TextStyle(fontSize: 50),
              ),
            )
          ],
        ),
      ),
    );
  }
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
