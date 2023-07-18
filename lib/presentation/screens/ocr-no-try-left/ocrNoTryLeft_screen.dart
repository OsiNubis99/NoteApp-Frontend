import 'package:flutter/material.dart';
import 'package:note_app_frontend/config/theme/app_theme.dart';
import '../../widgets/note/createNoteFAB_widget.dart';
import '../../widgets/shared/appBarMenu.dart';
import '../../widgets/shared/sidebar_menu.dart';

class NoTryLeftOCRScreen extends StatefulWidget {
  const NoTryLeftOCRScreen({super.key});

  @override
  State<NoTryLeftOCRScreen> createState() => _NoTryLeftOCRScreenState();
}

class _NoTryLeftOCRScreenState extends State<NoTryLeftOCRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:                       AppBarMenu(context),
      drawer:                       const SideBar(),
      body:                         const SafeArea(child: BodyContentWidget()),
      floatingActionButton:         const CreateNoteFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,      
    );
  }
}

class BodyContentWidget extends StatelessWidget {
  const BodyContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child:
    Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/robot@4x.png",
                  width: 320,
                  fit: BoxFit.cover,
                ),
        
        const SizedBox(height: 20),
        const Text('Nuestra IA necesita descansar', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Color.fromARGB(255, 23, 23, 23))), 
        const Text('Espera 24 horas o Avanza a una cuenta Premium'),
        const SizedBox(height: 20),
        ElevatedButton(
       style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary ,      
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  )),
          onPressed: () { },
          child: const Text('¡Avanzar a Premium!',style: TextStyle(color: AppTheme.text_dark),),
        )
        ],
    ));
  }
}