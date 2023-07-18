import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String idNota;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool status;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String? offlineStatus;

  Task({
    required this.id,
    required this.idNota,
    required this.status,
    required this.title,
    required this.date,
    this.offlineStatus,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id']['id'],
      idNota: json['idNota']['idNota'],
      title: json['title']['title'],
      status: json['status'] == 'listo',
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idNota': idNota,
      'text': title,
      'status': status ? 'listo' : 'por hacer',
      'fechaCreacion': date,
    };
  }
}
