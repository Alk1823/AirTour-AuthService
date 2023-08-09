import 'package:flutter/material.dart';
import 'package:reg_app/Views/LoginView.dart';
import 'package:reg_app/Views/RegisterView.dart';
import 'package:reg_app/Views/WelcomeView.dart';
import 'package:reg_app/constants/routes.dart';
import 'package:reg_app/Views/VerficationView.dart';
import 'package:reg_app/services/auth_service.dart';
import 'Views/NotesView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: const HomePage(),
    routes: {
      loginRoute :(context) => const LoginView(),
      registerRoute :(context) => const RegisterView(),
      notesRoute : (context) => const NotesView(),
      verficationRoute :(context) => const VerifyEmailView(),
      welcomeRoute :(context) => const WelcomeView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context,snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              }
              else {
                return const VerifyEmailView();
              }
            }
            else {
              return const WelcomeView();
            }
          default:
            return const CircularProgressIndicator(); 
        }
      },
      );
  }
}









