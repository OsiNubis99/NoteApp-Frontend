import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/infrastructure/models/task_model.dart';

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
  List<Task> tasks;

  @HiveField(6)
  List<Body> body;

  @HiveField(7)
  String? offlineStatus;

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
      status: json['estado']['estado'],
      tasks:
          List<Task>.from(json['tareas'].map((e) => Task.fromJson(e)).toList()),
      body: List<Body>.from(json['body'].map((e) => Body.fromJson(e)).toList()),
    );
  }

  Map<String, dynamic> toCreateJson() => {
        "titulo": title,
        "fechaC": date,
        "latitud": 0,
        "longitud": 0,
        "descripcionGPS": "Caracas",
        "est": status,
        "desc": description,
        "idUsuario": 1
      };

  Map<String, dynamic> toUpdateJson() => {
        "tituloNota": title,
        "fechaCreacion": date,
        "estado": status,
        "descrip": description
      };
}
