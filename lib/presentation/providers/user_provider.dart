import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class UserProvider extends ChangeNotifier {
  // Utils
  final _uuid = const Uuid();

  // Get Notes List
  void setId(String id) async {
    var box = Hive.box<String>('user');
    return box.put('id', id);
  }

  // Get Note By id
  String getId() {
    var box = Hive.box<String>('user');
    var id = box.get('id', defaultValue: '1');
    return '$id';
  }
}
