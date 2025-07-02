import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/home/home_screen.dart';
import 'package:halaqat_wasl_main_app/ui/profile/profile_screen.dart';
import 'package:halaqat_wasl_main_app/ui/requests/request_list_screen.dart';

// ignore: must_be_immutable
class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  List<Widget> screens = [HomeScreen(), RequestListScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: Builder(
        builder: (context) {
          final bottomNabBloc = context.read<BottomNavBloc>();
          return BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (context, state) {
              return Scaffold(
                bottomNavigationBar: NavigationBar(
                  selectedIndex: bottomNabBloc.selectedIndex,
                  onDestinationSelected: (value) =>bottomNabBloc.add(ChangeIndexEvent(index: value)),
                  destinations: [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.list_alt_sharp),
                      label: 'Requests',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person),
                      label: 'Person',
                    ),
                  ],
                ),
                body: screens.elementAt(bottomNabBloc.selectedIndex),
              );
            },
          );
        },
      ),
    );
  }
}
