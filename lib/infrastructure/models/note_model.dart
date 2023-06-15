// To parse this JSON data, do
//
//     final notesByUserId = notesByUserIdFromJson(jsonString);

import '../../domain/entities/note.dart';

class NotesByUserId {
    final String id;
    final String nombre;
    final String clave;
    final String usuario;
    final String correo;
    final DateTime fNacimiento;
    final List<NoteEntity> notes;

    NotesByUserId({
        required this.id,
        required this.nombre,
        required this.clave,
        required this.usuario,
        required this.correo,
        required this.fNacimiento,
        required this.notes,
    });

    factory NotesByUserId.fromJson(Map<String, dynamic> json) => NotesByUserId(
        id: json["id"],
        nombre: json["nombre"],
        clave: json["clave"],
        usuario: json["usuario"],
        correo: json["correo"],
        fNacimiento: DateTime.parse(json["f_nacimiento"]),
        notes: List<NoteEntity>.from(json["notes"].map((x) => Note.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "clave": clave,
        "usuario": usuario,
        "correo": correo,
        "f_nacimiento": "${fNacimiento.year.toString().padLeft(4, '0')}-${fNacimiento.month.toString().padLeft(2, '0')}-${fNacimiento.day.toString().padLeft(2, '0')}",
        "notes": List<NoteEntity>.from(notes.map((x) => x.toJson())),
    };
}

class Note {
    final String idNota;
    final String cuerpoNotaText;
    final String cuerpoNotaImg;
    final String estadoNota;
    final String etiquetaNota;
    final DateTime fechaNota;
    final String tituloNota;

    Note({
        required this.idNota,
        required this.cuerpoNotaText,
        required this.cuerpoNotaImg,
        required this.estadoNota,
        required this.etiquetaNota,
        required this.fechaNota,
        required this.tituloNota,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        idNota: json["idNota"],
        cuerpoNotaText: json["cuerpoNotaText"],
        cuerpoNotaImg: json["cuerpoNotaImg"],
        estadoNota: json["estadoNota"],
        etiquetaNota: json["etiquetaNota"],
        fechaNota: DateTime.parse(json["fechaNota"]),
        tituloNota: json["tituloNota"],
    );

    Map<String, dynamic> toJson() => {
        "idNota": idNota,
        "cuerpoNotaText": cuerpoNotaText,
        "cuerpoNotaImg": cuerpoNotaImg,
        "estadoNota": estadoNota,
        "etiquetaNota": etiquetaNota,
        "fechaNota": fechaNota.toIso8601String(),
        "tituloNota": tituloNota,
    };

    List<NoteEntity> toNoteEntity() {

        List<NoteEntity> notes = [];


        return notes;


    }
}
