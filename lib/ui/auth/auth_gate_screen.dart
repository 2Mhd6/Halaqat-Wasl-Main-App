import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/repo/auth/auth_repo.dart';
import 'package:halaqat_wasl_main_app/repo/user_operation/user_operation_repo.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';
import 'package:halaqat_wasl_main_app/ui/auth/log_in_screen.dart';
import 'package:halaqat_wasl_main_app/ui/auth/sign_up_screen.dart';
import 'package:halaqat_wasl_main_app/ui/home/home_screen.dart';

class AuthGateScreen extends StatelessWidget {
  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SetupSupabase.sharedSupabase.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final authState = snapshot.data;
        
        if (snapshot.connectionState == ConnectionState.waiting) {
           return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authState?.session == null) {
          return const SignUpScreen();
        }

        final userId = authState?.session?.user.id;
        if (userId == null) {
          return const LogInScreen();
        }

        
        return FutureBuilder(
          future: UserOperationRepo.getUserDetailsFromDB(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (userSnapshot.hasError || !userSnapshot.hasData) {
              return const LogInScreen(); 
            }

            final user = userSnapshot.data!;
            final role = user.role;
            GetIt.I.get<UserData>().user = user;
            if (role == 'user') {
              return const HomeScreen();
            } else{
              return Scaffold(
                body: Center(child: Text('You need to go ${role!} app'),),
              ); // or driver screen
            } 
          },
        );
      },
    );
  }
}
