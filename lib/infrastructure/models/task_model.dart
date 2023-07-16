class Task {
  int? id;
  bool? status;
  String? text;

  Task({this.id, this.status, this.text});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
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
