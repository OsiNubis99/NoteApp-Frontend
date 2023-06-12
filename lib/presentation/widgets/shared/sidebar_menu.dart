import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/login/login_screen.dart';

import '../../../config/theme/app_theme.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.bgGray,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          //Info User Account
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Usuario',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0XFF1F1F1F),
              ),
            ), 
            accountEmail: const Text(
              'usuario@email.com',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://i.pinimg.com/564x/00/80/ee/0080eeaeaa2f2fba77af3e1efeade565.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1623150502742-6a849aa94be4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //'Cerrar sesión'
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(builder: (context) => const LoginScreen());
              Navigator.pushReplacement(context, route);
              },
            child: const ListTile(
              title: Text(
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1F1F1F),),
              ),
            leading: Icon(Icons.exit_to_app_outlined),
            ),
          ),
        ],
      ),
    );
  }
}