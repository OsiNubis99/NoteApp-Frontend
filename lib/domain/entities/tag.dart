class TagEntity {
  String idEtiqueta;
  String nombreEtiqueta;
  String idUsuario;

  TagEntity({
    required this.idEtiqueta,
    required this.nombreEtiqueta,
    required this.idUsuario,
  });

  factory TagEntity.fromJson(Map<String, dynamic> json) => TagEntity(
        idEtiqueta: json["idEtiqueta"],
        nombreEtiqueta: json["nombreEtiqueta"],
        idUsuario: json["idUsuario"],
  );

  Map<String, dynamic> toJson() => {
        "idEtiqueta": idEtiqueta,
        "nombre": nombreEtiqueta,
        "idUsuario": idUsuario,
      };
}