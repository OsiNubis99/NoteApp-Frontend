import 'package:flutter/material.dart';
import 'package:note_app_frontend/presentation/screens/home/home_screen.dart';
import 'package:note_app_frontend/presentation/screens/start/start_screen.dart';

import '../../../config/theme/app_theme.dart';
import '../../screens/home/home_free_screen.dart';
import '../../screens/trash/trash_screen.dart';
import '../payment platform/payment_modal_widget.dart';

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
                    'https://images.unsplash.com/photo-1623150502742-6a849aa94be4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //'Home'
          GestureDetector(
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const HomeScreen());
              Navigator.push(context, route);
            },
            child: const ListTile(
              title: Text(
                'Menú Principal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1F1F1F),
                ),
              ),
              leading: Icon(Icons.home),
            ),
          ),

          GestureDetector(
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const HomeFreeScreen());
              Navigator.push(context, route);
            },
            child: const ListTile(
              title: Text(
                'Free',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1F1F1F),
                ),
              ),
              leading: Icon(Icons.free_breakfast),
            ),
          ),

          //Plan Premium
          GestureDetector(
            onTap: () {paymentModal(context);},
            child: const ListTile(
              title: Text(
                'Premium',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1F1F1F),),
              ),
              leading: Icon(Icons.card_membership),
            ),
          ),

          //papelera
          GestureDetector(
            onTap: () {
              final route = MaterialPageRoute(builder: (context) => const TrashScreen());
              Navigator.push(context, route);
            },
            child: const ListTile(
              title: Text(
                'Papelera',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1F1F1F),),
              ),
              leading: Icon(Icons.delete),
            ),
          ),

          //'Cerrar sesión'
          GestureDetector(
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const StartScreen());
              Navigator.push(context, route);
            },
            child: const ListTile(
              title: Text(
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF1F1F1F),
                ),
              ),
              leading: Icon(Icons.exit_to_app_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
