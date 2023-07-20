import 'package:hive_flutter/hive_flutter.dart';

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
  bool ocr;
  @HiveField(6)
  String? offlineStatus;

  Body({
    required this.id,
    required this.idNota,
    required this.text,
    required this.image,
    required this.date,
    required this.ocr,
    this.offlineStatus,
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      id: json['IDbody'],
      idNota: json['idNota'],
      text: json['text'],
      image: json['imagen'],
      date: DateTime.parse(json['fecha']),
      ocr: false,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      "fecha": date.toString(),
      "text": text,
      "imagen": image,
      "ocr": ocr
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'text': text,
      'image': image,
    };
  }
}
