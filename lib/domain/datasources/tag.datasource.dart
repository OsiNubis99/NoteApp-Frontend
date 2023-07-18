import '../entities/tag.dart';

abstract class TagDatasource {

  Future<List<TagEntity>> getAllTagByUser(String userID);

}