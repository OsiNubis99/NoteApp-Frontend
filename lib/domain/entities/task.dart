class TaskEntity {
  int? id = 8;
  bool? status = false;
  String? text = 'Task 8';

  TaskEntity({this.id, this.status, this.text});

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'],
      status: json['status'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'text': text,
    };
  }
}
