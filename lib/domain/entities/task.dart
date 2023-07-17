class TaskEntity {
  String id;
  String idNota;
  String title;
  bool status;
  DateTime date;

  TaskEntity({
    required this.id,
    required this.idNota,
    required this.status,
    required this.title,
    required this.date,
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
