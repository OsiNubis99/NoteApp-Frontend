import 'dart:convert';
import 'dart:io';
import '../../providers/note/note_provider.dart';

Future uploadImage(File? image) async {
  
  //FILE -> BASE64
  var bytes = File(image!.path).readAsBytesSync();
  String base64Image = base64Encode(bytes);
  print("pasando a base64: $base64Image");

  //ADD IMAGE TO DB

}