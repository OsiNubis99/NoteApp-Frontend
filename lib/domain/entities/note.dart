class NoteEntity {
  String idNota;
  String tituloNota;
  String descriptionNota;
  String fechaNota;
  String estadoNota;

  NoteEntity({
    required this.idNota,
    required this.tituloNota,
    required this.descriptionNota,
    required this.fechaNota,
    required this.estadoNota,
  });

  Map<String, dynamic> toJson() => {
        "idNota": idNota,
        "tituloNota": tituloNota,
        "cuerpoNotaText": descriptionNota,
        "fechaNota": fechaNota,
        "estadoNota": estadoNota,
      };
}
