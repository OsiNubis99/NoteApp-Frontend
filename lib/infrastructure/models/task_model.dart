import 'package:hive/hive.dart';

import '../enumns/offline_status.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? idNota;

  @HiveField(1)
  String? text;

  @HiveField(2)
  bool? status;

  @HiveField(3)
  DateTime? createdAt;

  @HiveField(4)
  OfflineStatus? oflineStatus;

  Task({this.idNota, this.text, status, this.createdAt}) {
    this.status = status == 'listo';
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      idNota: json['idNota'],
      text: json['text'],
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idNota': idNota,
      'text': text,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
