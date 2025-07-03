import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/home/home_screen.dart';
import 'package:halaqat_wasl_main_app/ui/profile/profile_screen.dart';
import 'package:halaqat_wasl_main_app/ui/requests/request_list_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';

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

              final selectedIndex = bottomNabBloc.selectedIndex;

              return Scaffold(

                bottomNavigationBar: AnimatedBottomNav(selectedIndex: selectedIndex, onIndexChanged: (value) => bottomNabBloc.add(ChangeIndexEvent(index: value))),
                body: screens.elementAt(bottomNabBloc.selectedIndex),
              );
            },
          );
        },
      ),
    );
  }
}




class AnimatedBottomNav extends StatelessWidget {
  
  const AnimatedBottomNav({super.key,required this.selectedIndex, required this.onIndexChanged,});

  final int selectedIndex;
  final void Function(int index) onIndexChanged;

  @override
  Widget build(BuildContext context) {

    final labels = ['Home', 'Requests', 'Account'];
    final icons = [LucideIcons.home, LucideIcons.clipboardList, LucideIcons.user];

    return Container(
      width: context.getWidth(),
      height: context.getHeight(multiplied: 0.1),
      padding: EdgeInsets.only(bottom: 32),

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(3, (i) {

            final isSelected = selectedIndex == i;

            return GestureDetector(
              onTap: () => onIndexChanged(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  // Animated icon size
                  TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: isSelected ? 20 : 32,
                      end: isSelected ? 32 : 20,
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutQuad,
                    builder: (context, size, _) => Icon(
                      icons[i],
                      size: size,
                      color: isSelected ? AppColors.primaryAppColor : AppColors.secondaryColor,
                    ),
                  ),

                  SizedBox(height: 4),

                  // Animated label 
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: AppTextStyle.sfPro12.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primaryAppColor : AppColors.secondaryColor,
                    ),
                    child: Text(labels[i]),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
