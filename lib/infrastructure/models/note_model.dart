import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_frontend/domain/entities/body.dart';
import 'package:note_app_frontend/domain/entities/task.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String date;
  @HiveField(4)
  String status;
  @HiveField(5)
  List<TaskEntity> tasks;
  @HiveField(6)
  List<BodyEntity> body;
  @HiveField(7)
  OfflineStatus? offlineStatus;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.tasks,
    required this.body,
    this.offlineStatus,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['idNota']['idNota'],
      title: json['tituloNota']['tituloNota'],
      description: json['descripcion']['descripcion'],
      date: json['fechaCreacion']['fecha'],
      status: json['estado'],
      tasks: json['tasks'].map((e) => TaskEntity.fromJson(e)).toList(),
      body: json['body'].map((e) => BodyEntity.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "idNota": id,
        "tituloNota": title,
        "descripcion": description,
        "fechaCreacion": date,
        "estado": status,
      };
}
