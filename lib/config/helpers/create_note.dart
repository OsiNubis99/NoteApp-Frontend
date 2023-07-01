import 'package:dio/dio.dart';

class CreateNoteService {
  final _dio = Dio();

  Future<dynamic> execute({
    required String description,
    required String title,
  }) async {
    final response =
        await _dio.post('https://mynoteapp-prod.up.railway.app/note', data: {
      "desc": description,
      "titulo": title,
      "fechaC": DateTime.now().toString().substring(0, 10),
      "est": 'Active',
    });
    return response.data;
  }
}
