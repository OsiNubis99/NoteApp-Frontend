class NoteEntity {
    final String idNota;
    final String cuerpoNotaText;
    final String cuerpoNotaImg;
    final String estadoNota;
    final String etiquetaNota;
    final String fechaNota;
    final String tituloNota;

    NoteEntity({
        required this.idNota,
        required this.cuerpoNotaText,
        required this.cuerpoNotaImg,
        required this.estadoNota,
        required this.etiquetaNota,
        required this.fechaNota,
        required this.tituloNota,
    });

    Map<String, dynamic> toJson() => {
        "idNota": idNota,
        "cuerpoNotaText": cuerpoNotaText,
        "cuerpoNotaImg": cuerpoNotaImg,
        "estadoNota": estadoNota,
        "etiquetaNota": etiquetaNota,
        "fechaNota": fechaNota,
        "tituloNota": tituloNota,
    };
}