
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/shared/alertSnackBar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});


  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,

      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            final route = MaterialPageRoute(builder: (context) => const HomeScreen()); //cambiar a vista de planes cuando ya esté
              Navigator.pushReplacement(context, route);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        title: Image.asset(
          "assets/my_notes_app.png",
          width: 130,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.text_dark),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.text_dark),
              onPressed: () async {},
          ),
        ],
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
          
                //Imagen
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/Payment.png",
                    width: 300,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
          
                const SizedBox(height: 20,),
          
                //
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: const Color(0xFFFFFFFF),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
          
                //
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: const Color(0xFFFFFFFF),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
          
                //
                Row(
                  children: [
          
                    //
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: const Color(0xFFFFFFFF),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
          
                    //
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: const Color(0xFFFFFFFF),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //Buttom
                Padding(padding: const EdgeInsets.only(top: 35.0, left: 20, right: 20, bottom: 30),
                child: Row(
                  children: [ Expanded(
                      child: MaterialButton(
                        color: const Color(0xFFEDC123),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5),),

                        onPressed: () {confirmPayment(context);},

                        child: Padding(padding: const EdgeInsets.all(15.0),
                          child: Column(children: <Widget>[ 
                              Text( "Procesar pago", style: Theme.of(context).textTheme.displaySmall,),],
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
    );
  }

  void confirmPayment(BuildContext context) {
    var intValue = Random().nextInt(6);

    if (intValue == 1){
      SnackBar snackBar = AlertSnackBar(titulo: "Pago rechazado", mensaje: "Ocurrió un error al procesar el pago, por favor intenta nuevamente", tipo: ContentType.failure);
      
      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    }
    else {
      SnackBar snackBar = AlertSnackBar(titulo: "¡Bienvenido!", mensaje: "Tu pago fue procesado éxitosamente", tipo: ContentType.success);
      
      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    }
  }

  
}