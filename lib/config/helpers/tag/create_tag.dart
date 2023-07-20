import 'package:dio/dio.dart';

class CreateTagService {
  final _dio = Dio();

  Future<dynamic> execute({
    required String nombreEtiqueta,
    required String idUsuario,
  }) async {
    final response =
        await _dio.post('https://noteapp-backend-prod.up.railway.app/tag', data: {
      "nombre": nombreEtiqueta,
      "idUsuario": idUsuario,
    });
    return response.data;
  }
}
