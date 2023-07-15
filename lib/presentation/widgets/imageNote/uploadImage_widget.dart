import 'dart:convert';
import 'dart:io';

Future uploadImage(File? image) async {
  
  //FILE -> BASE64
  var bytes = File(image!.path).readAsBytesSync();
  String base64Image = base64Encode(bytes);
  print("File a base64: $base64Image");

  //ADD IMAGE TO DB

}