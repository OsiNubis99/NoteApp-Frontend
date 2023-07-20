import '../../domain/entities/tag.dart';

class TagsByUserId {
    final String id;
    final String nombre;
    final String clave;
    final String usuario;
    final String correo;
    final DateTime fNacimiento;
    final List<TagEntity> tags;

    TagsByUserId({
        required this.id,
        required this.nombre,
        required this.clave,
        required this.usuario,
        required this.correo,
        required this.fNacimiento,
        required this.tags,
    });

    factory TagsByUserId.fromJson(Map<String, dynamic> json) => TagsByUserId(
        id: json["id"],
        nombre: json["nombre"],
        clave: json["clave"],
        usuario: json["usuario"],
        correo: json["correo"],
        fNacimiento: DateTime.parse(json["f_nacimiento"]),
        tags: List<TagEntity>.from(json["tags"].map((x) => Tag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "clave": clave,
        "usuario": usuario,
        "correo": correo,
        "f_nacimiento": "${fNacimiento.year.toString().padLeft(4, '0')}-${fNacimiento.month.toString().padLeft(2, '0')}-${fNacimiento.day.toString().padLeft(2, '0')}",
        "tags": List<TagEntity>.from(tags.map((x) => x.toJson())),
    };
}

class Tag {
  String idEtiqueta;
  String nombreEtiqueta;
  String idUsuario;

  Tag({
    required this.idEtiqueta,
    required this.nombreEtiqueta,
    required this.idUsuario,
  });


    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        idEtiqueta: json["idEtiqueta"],
        nombreEtiqueta: json["nombreEtiqueta"],
        idUsuario: json["idUsuario"],
    );

    
      Map<String, dynamic> toJson() => {
        "idEtiqueta": idEtiqueta,
        "nombre": nombreEtiqueta,
        "idUsuario": idUsuario,
      };

    List<TagEntity> toTagEntity() {

        List<TagEntity> tags = [];


        return tags;


    }
}