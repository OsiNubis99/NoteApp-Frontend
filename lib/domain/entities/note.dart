class NoteEntity {
  String idNota;
  String tituloNota;
  String descriptionNota;
  String fechaNota;
  String estadoNota;
  String descripcionGPS;
  int    latitud;
  int    longitud;


  NoteEntity({
    required this.idNota,
    required this.tituloNota,
    required this.descriptionNota,
    required this.fechaNota,
    required this.estadoNota,
     this.descripcionGPS = '',
     this.latitud    = 0,
     this.longitud   = 0,
  });

  Map<String, dynamic> toJson() => {
        "idNota": idNota,
        "tituloNota": tituloNota,
        "cuerpoNotaText": descriptionNota,
        "fechaNota": fechaNota,
        "estadoNota": estadoNota,
        "descripcionGPS": descripcionGPS,
        "latitud": latitud,
        "longitud": longitud,
      };
}
