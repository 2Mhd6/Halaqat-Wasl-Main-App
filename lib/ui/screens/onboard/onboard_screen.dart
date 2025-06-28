import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/screens/home/home_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/login_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/onboard/onboard_item.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/profile_screen.dart';
import 'bloc/onboard_bloc.dart';

// displays the first onboarding page.
class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});
  static const routeName = '/onboard';

  _navigate(BuildContext context) {

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProfileScreen()));
    return;

    // TODO Convert Navigation to match app navigation
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
          final pages = [
            OnBoardItem(
              image: 'assets/images/onboard1.png',
              title: 'Welcome to Halaqt Wasl',
              description:
                  'Helping seniors reach \n their appointments safely \n and on time.',
            ),
            OnBoardItem(
              image: 'assets/images/onboard2.png',
              title: 'Connected to the Association',
              description:
                  'Your trips are coordinated\nand tracked in real-time\nby the organization',
            ),
            OnBoardItem(
              image: 'assets/images/onboard3.png',
              title: 'Let’s Go',
              description:
                  'Your next ride is just a tap away.\nWe’re here to serve you.',
            ),
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: BlocConsumer<OnboardBloc, OnboardState>(
                listener: (context, state) {
                  if (getIndex(state) == -1) {
                    // Navigate to main page
                    _navigate(context);
                  } else {
                    bloc.pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                builder: (BuildContext context, OnboardState state) {
                  final currentIndex = getIndex(state) == -1
                      ? pages.length - 1
                      : getIndex(state);

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: GestureDetector(
                            onTap: () {
                              _navigate(context);
                            },
                            child: Text(
                              'Skip',
                              style: AppTextStyle.sfProBold16.copyWith(
                                color: AppColor.primaryButtonColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap.gapH80,
                      Expanded(
                        flex: 2,
                        child: PageView.builder(
                          controller: bloc.pageController,
                          itemCount: pages.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),

                              child: Column(
                                key: ValueKey(index),
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      pages[index].title,
                                      key: ValueKey(pages[index].title),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Gap.gapH40,
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
                                  AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: Text(
                                      pages[index].description,
                                      key: ValueKey(pages[index].description),
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) => Container(
                                  height: 5.0,
                                  width: 20.0,
                                  margin: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: currentIndex == index
                                        ? AppColor.primaryButtonColor
                                        : AppColor.acceptedBackgroundColor,
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
                                  AppColor.primaryButtonColor,
                                ),
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(vertical: 12.0),
                                ),
                              ),
                              child: Text(
                                currentIndex == pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
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
