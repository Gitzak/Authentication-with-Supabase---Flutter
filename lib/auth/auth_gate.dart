/*
  AUTH GATE This will continuously listen for auth state changes.
  --------------------------------------------------------------
  unauthenticated -> Login Page
  authenticated -> Profile Page
*/
import 'package:flutter/material.dart';
import 'package:supabase_app/screens/login_page.dart';
import 'package:supabase_app/screens/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          debugPrint("User is authenticated, redirecting to ProfilePage");
          return const ProfilePage();
        } else {
          debugPrint("User is not authenticated, redirecting to LoginPage");
          return const LoginPage();
        }
      },
    );
  }
}
