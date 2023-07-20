import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_frontend/infrastructure/models/body_model.dart';
import 'package:note_app_frontend/infrastructure/models/task_model.dart';
import 'package:note_app_frontend/infrastructure/models/user_data.dart';

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
  num latitude;

  @HiveField(6)
  num longitude;

  @HiveField(7)
  String address;

  @HiveField(8)
  List<Task> tasks;

  @HiveField(9)
  List<Body> body;

  @HiveField(10)
  String? offlineStatus;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.tasks,
    required this.body,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.offlineStatus,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['idNota']['idNota'],
      title: json['tituloNota']['tituloNota'],
      description: json['descripcion']['descripcion'],
      date: json['fechaCreacion']['fecha'],
      status: json['estado']['estado'],
      latitude: json['geolocalizacion']['latitud'],
      longitude: json['geolocalizacion']['longitud'],
      address: json['geolocalizacion']['descripcion'],
      tasks:
          List<Task>.from(json['tareas'].map((e) => Task.fromJson(e)).toList()),
      body: List<Body>.from(json['body'].map((e) => Body.fromJson(e)).toList()),
    );
  }

  Map<String, dynamic> toCreateJson() => {
        "titulo": title,
        "fechaC": date.toString(),
        "latitud": latitude,
        "longitud": longitude,
        "descripcionGPS": address,
        "est": status,
        "desc": description,
        "idUsuario": UserData().id
      };

  Map<String, dynamic> toUpdateJson() => {
        "titulo": title,
        "fechaC": date.toString(),
        "est": status,
        "latitud": latitude,
        "longitud": longitude,
        "descripcionGPS": address,
        "desc": description
      };
}
