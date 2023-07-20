import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../../screens/note/noteList_screen.dart';
import '../payment platform/payment_modal_widget.dart';
import 'menu_item.dart';

class MenuFreeOptionsWidget extends StatelessWidget {
  const MenuFreeOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment(0.0, 0.0),
        //   end: Alignment(0.25, 0.75),
        //   colors: <Color>[
        //     Color(0xFFFFE162),
        //     Color(0xFF6FB2D2),
        //   ],
        //),
        color: AppTheme.bgGray,
      ),
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 18,vertical: 10),
        child: Column(
          children:  [
      
            const  SizedBox(
          height: 10,
        ),
      
        //   const Text('Explora                                 '
        //   ,textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 32)),
      
        //  const SizedBox(
        //         height: 20,
        //   ),

        const FreeToPremiumButton(),

          
        
        const SizedBox(
          height: 20,
        ),
               
        HomeItem(title: 'Lista de Notas     ',    bodyText: 'Cree, edite o elimine sus notas', color: AppTheme.note_1, icon: Icons.note,               onPressed: () {final route = MaterialPageRoute(builder: (context) => const NoteListScreen());  Navigator.pushReplacement(context, route); },),     
        
        const SizedBox(
          height: 30,
        ),  
      
          ],
      
         
        ),
      ),
    );
    
  }
}

class FreeToPremiumButton extends StatelessWidget {
  const FreeToPremiumButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () { paymentModal(context); },
      child: Image.asset(
      "assets/robotPremium.png",
      width: 640 ,
    ),);
  }
}