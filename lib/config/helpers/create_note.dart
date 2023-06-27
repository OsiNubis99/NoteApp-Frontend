import 'package:dio/dio.dart';

class CreateNote {
  final _dio = Dio();

  Future<bool> createNote({
    required String description,
    required String title,
  }) async {
    final response =
        await _dio.post('https://mynoteapp-dev.up.railway.app/note', data: {
      "desc": description,
      "titulo": title,
      "fechaC": DateTime.now().toString().substring(0, 10),
      "est": 'Active',
    });
    return response.data != null;
  }
}
