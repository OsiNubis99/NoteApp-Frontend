import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';

class TaskEntity {
  String id;
  String idNota;
  String title;
  bool status;
  DateTime date;
  OfflineStatus? offlineStatus;

  TaskEntity({
    required this.id,
    required this.idNota,
    required this.status,
    required this.title,
    required this.date,
    this.offlineStatus,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id']['id'],
      idNota: json['idNota']['idNota'],
      title: json['title']['title'],
      status: json['status'] == 'listo',
      date: json['date'],
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
