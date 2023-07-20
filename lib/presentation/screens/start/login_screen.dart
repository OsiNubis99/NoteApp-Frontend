import 'package:flutter/material.dart';
import '../../../config/theme/app_theme.dart';
import '../../providers/user_provider.dart';
import '../home/home_free_screen.dart';
import '../home/home_screen.dart';
//import 'package:note_app_frontend/domain/entities/usuario.dart';

//import 'package:http/http.dart' as http;
//import 'dashboard_screen.dart';
//import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _userProvider = UserProvider();

  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,

      //AppBar (Icon arrow)
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 50.0),
          child: Form(
            key: _formfield,
            child: Column(
              children: <Widget>[
                //Imagen principal
                Image.asset(
                  "assets/NoteAppD.png",
                  width: 235,
                  fit: BoxFit.cover,
                ),

                //Imagen Nombre App
                Image.asset(
                  "assets/my_notes_app.png",
                  width: 140,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 50),

                //email
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: const Color(0xFFFFFFFF),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      label: Text("Correo electrónico"),
                      labelStyle:
                          TextStyle(fontSize: 15, color: AppTheme.text_dark),
                      hintText: "nombre@ejemplo.com",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.black26),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Ingrese su correo electrónico";
                      } else if (!emailValid) {
                        return "Ingrese un correo electrónico válido";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                //password
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: const Color(0xFFFFFFFF),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordController,
                    obscureText: passwordToggle,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      label: const Text("Clave"),
                      labelStyle: const TextStyle(
                          fontSize: 15, color: AppTheme.text_dark),
                      hintText: "********",
                      hintStyle:
                          const TextStyle(fontSize: 18, color: Colors.black26),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passwordToggle = !passwordToggle;
                          });
                        },
                        child: Icon(passwordToggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ingrese una clave";
                      } else if (value != "LaClave23*") {
                        return "Ingrese un clave válida";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),

                //Button 'iniciar sesion'
                Padding(
                  padding: const EdgeInsets.only(
                      top: 35.0, left: 20, right: 20, bottom: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: const Color(0xFFEDC123),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),

                          //Navigator
                          onPressed: () {
                            if (_formfield.currentState!.validate()) {
                              if (emailController.text ==
                                  "jerojas696969@gmail.com") {
                                _userProvider.setId('2');
                                final route = MaterialPageRoute(
                                    builder: (context) =>
                                        const HomeScreen());
                                Navigator.pushReplacement(context, route);
                                emailController.clear();
                                passwordController.clear();
                              } else if (emailController.text ==
                                  "asensio_elpro@gmail.com") {
                                _userProvider.setId('1');
                                final route = MaterialPageRoute(
                                    builder: (context) => const HomeFreeScreen());
                                Navigator.pushReplacement(context, route);
                                emailController.clear();
                                passwordController.clear();
                              }
                            }
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Iniciar Sesión",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
