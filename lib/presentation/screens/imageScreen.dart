import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/shared/sidebar_menu.dart';

class ImageScreen extends StatefulWidget {
  final String? path;

  const ImageScreen({Key? key, this.path}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    //final noteProvider = context.watch<NoteProvider>();

    return const Scaffold(
      drawer: SideBar(),
    );
  }
}