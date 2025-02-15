class BodyEntity {
  String id;
  String idNota;
  String text;
  Map<String, dynamic> image; // Base64
  DateTime date;
  String? offlineStatus;

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
