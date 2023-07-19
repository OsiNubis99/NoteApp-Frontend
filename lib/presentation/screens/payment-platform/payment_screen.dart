
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:note_app_frontend/presentation/widgets/shared/sidebar_menu.dart';

import '../../../config/theme/app_theme.dart';
import '../../widgets/shared/alertSnackBar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});


  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var numberCard = MaskTextInputFormatter(mask: '#### #### #### ####', filter: { "#": RegExp(r'[0-9]') });
  var dateCard = MaskTextInputFormatter(mask: '##/##', filter: { "#": RegExp(r'[0-9]') });
  var digitCard = MaskTextInputFormatter(mask: '###', filter: { "#": RegExp(r'[0-9]') });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgGray,
      drawer: const SideBar(),
      appBar: AppBar(
        backgroundColor: AppTheme.bgGray,
        elevation: 0,
        title: Image.asset(
          "assets/my_notes_app.png",
          width: 130,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppTheme.text_dark),
        actions: [
          IconButton(
          onPressed: () {
            final route = MaterialPageRoute(builder: (context) => const HomeScreen());
              Navigator.pushReplacement(context, route);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0XFF000000)),
        ),
        ],
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
          
                //Imagen
                Padding(
                  padding: const EdgeInsets.only(bottom:15, top: 20),
                  child: Image.asset("assets/Payment.png",
                    width: 280,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
          
                const SizedBox(height: 20,),
          
                //name
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: const Color(0xFFFFFFFF),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      label: Text("Nombre en la tarjeta"),
                      labelStyle: TextStyle(fontSize: 15, color: AppTheme.text_dark),
                      hintText: "Nombre A Apellido",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.black26),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
          
                //card
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                    color: const Color(0xFFFFFFFF),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    inputFormatters: [numberCard],
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      label: Text("Número de tarjeta"),
                      hintText: "0000 0000 0000 0000",
                      hintStyle: TextStyle(fontSize: 18, color: Colors.black26),
                      labelStyle: TextStyle(fontSize: 15, color: AppTheme.text_dark),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(Icons.payment)
                    ),
                  ),
                ),
                const SizedBox(height: 10),
          
                
                Row(
                  children: [
          
                    //date
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: const Color(0xFFFFFFFF),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          inputFormatters: [dateCard],
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            label: Text("Fecha vencimiento"),
                            hintText: "07/24",
                            hintStyle: TextStyle(fontSize: 18, color: Colors.black26),
                            labelStyle: TextStyle(fontSize: 15, color: AppTheme.text_dark),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
          
                    //cvv
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: const Color(0xFFFFFFFF),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          inputFormatters: [digitCard],
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            label: Text("CVV"),
                            hintText: "000",
                            hintStyle: TextStyle(fontSize: 18, color: Colors.black26),
                            labelStyle: TextStyle(fontSize: 15, color: AppTheme.text_dark),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //Buttom
                Padding(padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20, bottom: 30),
                child: Row(
                  children: [ Expanded(
                      child: MaterialButton(
                        color: const Color(0xFFEDC123),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5),),

                        onPressed: () {
                          confirmPayment(context);
                        },

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
      
      final route = MaterialPageRoute(builder: (context) => const HomeScreen());
      Navigator.pushReplacement(context, route);

    }
  }

  
}