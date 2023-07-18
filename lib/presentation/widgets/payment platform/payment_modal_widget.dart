import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';

void paymentModal(BuildContext context){
  showModalBottomSheet(
    context:context, 
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15,left: 15),
        height: 220,
        child: Column(
          children: [

            Column(
                children: [
                  const ListTile(
                    title: Text(
                      '¡Comienza a ser premium!',
                      style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0XFF1F1F1F), ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 20, right: 15, left: 15),
                    child: const Text("Agrega los datos de tu tarjeta para procesar el pago. No te preocupes, tu información no se comparte", textAlign: TextAlign.start,)),
                ]
              ),

            //ADD CREDIT OR DEBIT CARD
            MaterialButton(
              onPressed: (){},
              child: const PaymentModalCard(title: "    Agregar tarjeta de crédito o débito"),
            ),
          ],
        ),
      );
    },
  );
}

class PaymentModalCard extends StatelessWidget {
  final String title;

  const PaymentModalCard({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(color: AppTheme.primary,),
          child: Row(
              children: <Widget>[
                const Icon(Icons.add_card,),
                Text(
                  title, 
                  textAlign: TextAlign.start,
                  style: AppTheme.lightTheme.textTheme.displaySmall,
                ),
              ],
          ),
        )
    );
  }
}