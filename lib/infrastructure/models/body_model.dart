import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';

part 'body_model.g.dart';

@HiveType(typeId: 1)
class Body extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String idNota;
  @HiveField(2)
  String text;
  @HiveField(3)
  Map<String, dynamic> image; // Base64
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String? offlineStatus;

  Body({
    required this.id,
    required this.idNota,
    required this.text,
    required this.image,
    required this.date,
    this.offlineStatus,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      id: json['IDbody'],
      idNota: json['idNota'],
      text: json['text'],
      image: json['imagen'],
      date: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Idbody': id,
      'idNota': idNota,
      'text': text,
      'image': image,
      'fecha': date,
    };
  }
}
