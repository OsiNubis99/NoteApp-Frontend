import 'package:flutter/material.dart';
import '../../widgets/shared/appBarMenuBack.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarMenuBack(context),
    body: Container(
      padding: const EdgeInsets.all(30),
      child: Text(text),
    ),
  );
}