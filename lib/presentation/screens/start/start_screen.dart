import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import 'login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      body: SafeArea(
        child: Padding(padding:const EdgeInsets.only(top: 145, bottom: 5.0),
          child: Column(
            children: <Widget> [

              //Imagen principal
                Image.asset("assets/NoteAppD.png",
                  width: 235,
                  fit: BoxFit.cover,
                ),const Spacer(),
              
          
              //Imagen Nombre App
                Image.asset("assets/my_notes_app.png",
                  width: 155,
                  fit: BoxFit.cover,
                ),const Spacer(),

              //'Iniciar sesion'
              Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 20, right: 20, bottom: 5.0),
                child: Row(
                  children: [ Expanded(
                      child: MaterialButton(
                        color: const Color(0xFFEDC123),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),

                        //Navigator
                        onPressed: () {
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen()));},
                       
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(children: <Widget>[ 
                              Text(
                                "Iniciar Sesión",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //'Crear cuenta'
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 5.0),
                child: Row(
                  children: [ Expanded(
                      child: MaterialButton(
                        color: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color(0xFFEDC123),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        
                        //Navigator
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const NewAccountScreen()));
                        },
                        
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(children: <Widget>[ 
                              Text(
                                "Crear nueva cuenta",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}