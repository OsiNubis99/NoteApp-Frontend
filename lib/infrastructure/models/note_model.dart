

class NoteModel {
  String Titulo;
  String Cuerpo;

  NoteModel({
    required this.Titulo,
    required this.Cuerpo,
  });

  factory NoteModel.fronJsonMap( Map<String,dynamic> json) 
  => NoteModel(Titulo: json['Titulo'], Cuerpo: json['Cuerpo']); 
}