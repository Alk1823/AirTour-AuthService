import 'package:flutter/material.dart';
import 'package:reg_app/constants/routes.dart';

import '../services/auth_service.dart';

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(welcomeRoute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, //what apears to programmer
                  child: Text('Log Out'), //what will apear to user
                )
              ];
            },
          )
        ],
      ),
      body: const Text('hello wrold')
    );
  }
}

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog( 
        title: const Text('Log Out'),
        content: const Text("Are you sure you want to Log Out?"),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
             child: const Text('Log Out')),
        ],
      );
    },
    ).then((value) => value ?? false);
}