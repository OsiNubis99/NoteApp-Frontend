import 'package:note_app_frontend/infrastructure/enumns/offline_status.dart';

class BodyEntity {
  String id;
  String idNota;
  String text;
  String image; // Base64
  DateTime date;
  OfflineStatus? offlineStatus;

  BodyEntity({
    required this.id,
    required this.idNota,
    required this.text,
    required this.image,
    required this.date,
    this.offlineStatus,
  });

  factory BodyEntity.fromJson(Map<String, dynamic> json) {
    return BodyEntity(
      id: json['IDbody'],
      idNota: json['idNota'],
      text: json['text'],
      image: json['imagen'],
      date: json['fecha'],
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
