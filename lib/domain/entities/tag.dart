class TagEntity {
  String idEtiqueta;
  String nombreEtiqueta;
  String idUsuario;

  TagEntity({
    required this.idEtiqueta,
    required this.nombreEtiqueta,
    required this.idUsuario,
  });

  Map<String, dynamic> toJson() => {
        "idEtiqueta": idEtiqueta,
        "nombre": nombreEtiqueta,
        "idUsuario": idUsuario,
      };
}