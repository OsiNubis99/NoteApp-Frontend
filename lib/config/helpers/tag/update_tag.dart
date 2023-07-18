import 'package:dio/dio.dart';

import '../../../domain/entities/tag.dart';

class UpdateTag {
  final _dio = Dio();

  Future<dynamic> execute({
    required TagEntity tag,
  }) async {
    final response =
        await _dio.put('https://noteapp-backend-prod.up.railway.app/tag/${tag.idEtiqueta}', data: {
      "nombre": tag.nombreEtiqueta,
      "idUsuario": tag.idUsuario,
    });
    return response.data;
  }
}
