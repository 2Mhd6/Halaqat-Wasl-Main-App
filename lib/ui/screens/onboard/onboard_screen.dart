import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/screens/home/home_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/login_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/onboard/onboard_item.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/onboard_bloc.dart';

// displays the first onboarding page.
class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});
  static const routeName = '/onboard';

  _navigate(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Sets the onboarding as completed for the user
    await prefs.setBool('firstTime', false);

    // Navigate to profile screen
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
    return;

    // TODO Convert Navigation to match app navigation
    if (context.mounted) {
      final isLoggedin = false;
      final Widget page;
      // ignore: dead_code
      if (isLoggedin) {
        page = HomeScreen();
      } else {
        page = LoginScreen();
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return page;
          },
        ),
      );
    }
  }
  // Get current onboarding page
  int getIndex(OnboardState state) => switch (state) {
    FirstOnboardState() => 0,
    SecondOnboardState() => 1,
    ThirdOnboardState() => 2,
    EndOnboardState() => -1,
  };
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardBloc>(
      create: (context) => OnboardBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.watch<OnboardBloc>();
          final duration = Duration(milliseconds: 500);
          // List of onboarding pages
          final pages = [
            OnBoardItem(
              image: 'assets/images/onboard1.png',
              title: tr('onboarding_screen.first_title'),
              description:
                  tr('onboarding_screen.first_body'),
            ),
            OnBoardItem(
              image: 'assets/images/onboard2.png',
              title: tr('onboarding_screen.second_title'),
              description:
                     tr('onboarding_screen.second_body'),            ),
            OnBoardItem(
              image: 'assets/images/onboard3.png',
              title: tr('onboarding_screen.third_title'),
              description:
                     tr('onboarding_screen.third_body'),            ),
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: BlocConsumer<OnboardBloc, OnboardState>(
                listener: (context, state) {
                  if (getIndex(state) == -1) {
                    // Navigate to main page
                    _navigate(context);
                  }
                },
                builder: (BuildContext context, OnboardState state) {
                  // Get the current page index
                  final currentIndex = getIndex(state) == -1
                      ? pages.length - 1
                      : getIndex(state);

                  return Column(
                    children: [
                      // Skip button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: GestureDetector(
                            onTap: () {
                              _navigate(context);
                            },
                            child: Text(
                              tr('onboarding_screen.skip'),
                              style: AppTextStyle.sfProBold16.copyWith(
                                color: AppColors.primaryButtonColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap.gapH80,
                      Expanded(
                      // Page content (title - image - description)
                        flex: 2,
                        child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),

                              child: Column(
                                key: ValueKey(currentIndex),
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Title
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      pages[currentIndex].title,
                                      key: ValueKey(pages[currentIndex].title),
                                      style: AppTextStyle.sfProBold24.copyWith(
                                        color: Color(0xffAAB3D5),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Gap.gapH40,
                                   // Image
                                  AnimatedSwitcher(
                                    duration: duration,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        pages[currentIndex].image,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                  Gap.gapH40,
                                  // Description
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      pages[currentIndex].description,
                                      key: ValueKey(pages[currentIndex].description),
                                      style: AppTextStyle.sfProBold24.copyWith(
                                        color: Color(0xffAAB3D5),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                      Column(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                pages.length,
                                (index) => Container(
                                  height: 5.0,
                                  width: 20.0,
                                  margin: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: currentIndex == index
                                        ? AppColors.primaryButtonColor
                                        : AppColors.acceptedBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 32.0,
                            ),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<OnboardBloc>().add(
                                  PageChangedEvent(),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  AppColors.primaryButtonColor,
                                ),
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 12.0),
                                ),
                              ),
                              child: Text(
                                currentIndex == pages.length - 1
                                    ? tr('onboarding_screen.get_started')
                                    : tr('onboarding_screen.next'),
                                style: AppTextStyle.sfProBold20.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
