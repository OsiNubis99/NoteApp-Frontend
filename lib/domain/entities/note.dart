class NoteEntity {
  final String idNota;
  final String tituloNota;
  final String descriptionNota;
  final String fechaNota;
  final String estadoNota;

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
