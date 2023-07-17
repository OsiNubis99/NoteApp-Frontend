import 'package:flutter/material.dart';

import '../../../config/helpers/tag/create_tag.dart';
import '../../../config/helpers/tag/update_tag.dart';
import '../../../domain/entities/tag.dart';


class TagProvider extends ChangeNotifier {
  final CreateTagService createTag = CreateTagService();
  final UpdateTag updateTagService = UpdateTag();

  List<TagEntity> tags = [];

  Future<dynamic> addTag({
    required String nombreEtiqueta,
    required String idUsuario,
  }) async {
    final response = await createTag.execute(
      nombreEtiqueta: nombreEtiqueta,
      idUsuario: idUsuario,
    );
    notifyListeners();
    return response;
  }

  Future<dynamic> updateTag(TagEntity tag) async {
    final response = await updateTagService.execute(tag: tag);
    notifyListeners();
    return response;
  } 
}
