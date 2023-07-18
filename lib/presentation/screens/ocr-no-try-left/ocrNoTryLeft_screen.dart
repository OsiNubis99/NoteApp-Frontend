import 'package:flutter/material.dart';
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
        const Text('No se encontro alguna nota', style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Color.fromARGB(255, 23, 23, 23))), 
        const Text('Crear una nota en el boton de más'),
        ],
    ));
  }
}