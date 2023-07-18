import 'package:flutter/material.dart';

class NoteNotFound extends StatelessWidget {
  const NoteNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:  [ 
        const SizedBox(height: 10),
         //Imagen Nombre App
          Image.asset("assets/note-empty.png",
                  width: 140,
                  fit: BoxFit.cover,
                ),
        
        const SizedBox(height: 20),
        const Text('No se encontro alguna nota', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Color.fromARGB(255, 23, 23, 23))), 
        const Text('Crear una nota en el boton de más'),

      ],
    );
  }
}