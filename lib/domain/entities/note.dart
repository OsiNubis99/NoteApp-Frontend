import 'package:note_app_frontend/domain/entities/body.dart';
import 'package:note_app_frontend/domain/entities/task.dart';

class NoteEntity {
  String id;
  String title;
  String description;
  String date;
  String status;
  List<TaskEntity> tasks;
  List<BodyEntity> body;

  NoteEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.tasks,
    required this.body,
  });

  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json['idNota'],
      title: json['tituloNota'],
      description: json['description'],
      date: json['fechaNota'],
      status: json['estadoNota'],
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
