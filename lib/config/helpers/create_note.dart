import 'package:dio/dio.dart';

class CreateNote{
  final _dio = Dio();


  Future<void> createNote({
    required  String text,
              String img      = 'img',
              String etiquet  = 'Etiqueta',
    required  String titulo,
              String fechaC   = '2023-06-21',
              String est      = 'Active',
  }) async{

    final response = await _dio.post('https://mynoteapp-prod.up.railway.app/note',
             data:{
              "text"   : text,
              "img"    : img,
              "etiquet": etiquet,
              "titulo" : titulo,
              "fechaC" : fechaC,
              "est"    : est 
             }
             );  

  }

  
}