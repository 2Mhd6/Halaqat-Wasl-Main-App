import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/user_data.dart';
import 'package:halaqat_wasl_main_app/repo/user_operation/user_operation_repo.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';
import 'package:halaqat_wasl_main_app/ui/auth/bloc/auth_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/auth/log_in_screen.dart';
import 'package:halaqat_wasl_main_app/ui/auth/sign_up_screen.dart';
import 'package:halaqat_wasl_main_app/ui/bottom_nav/bottom_nav_screen.dart';

class AuthGateScreen extends StatelessWidget {
  const AuthGateScreen({super.key, this.whereYouWantToGo});

  final String? whereYouWantToGo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: SetupSupabase.sharedSupabase.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (whereYouWantToGo == 'sign_up') {
          return SignUpScreen();
        } else if (whereYouWantToGo == 'log_in') {
          return LogInScreen();
        }
        final authState = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (authState == null || authState.session == null) {
          return BlocProvider(
            create: (context) => AuthBloc(),
            child: LogInScreen(),
          );
        }

        return FutureBuilder(
          future: UserOperationRepo.getUserDetailsFromDB(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (userSnapshot.hasError || !userSnapshot.hasData) {
              return BlocProvider(
                create: (context) => AuthBloc(),
                child: LogInScreen(),
              );
            }

            final user = userSnapshot.data!;
            final role = user.role;
            GetIt.I.get<UserData>().user = user;
            if (role == 'user') {
              return BottomNavScreen();
            } else {
              return Scaffold(
                body: Center(child: Text('You need to go ${role!} app')),
              ); // or driver screen
            }
          },
        );
      },
    );
  }
}
