import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:halaqat_wasl_main_app/data/shared_local_storage.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_custom_button.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/auth/auth_gate_screen.dart';
import 'package:halaqat_wasl_main_app/ui/onboarding/bloc/onboarding_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: Builder(
        builder: (context) {
          final onboardingBloc = context.read<OnboardingBloc>();

          return BlocListener<OnboardingBloc, OnboardingState>(
            listener: (context, state) async {
              if (state is SuccessPresentingOnboarding) {
                await GetIt.I.get<SharedLocalStorage>().sharedPreference!.setBool('isFirstTime', false);

                await Future.delayed(Duration(milliseconds: 200));
                if(context.mounted){
                  context.moveToWithReplacement(context: context, screen: AuthGateScreen());
                }
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(LucideIcons.languages),
                          ),
                          TextButton(
                            onPressed: () => onboardingBloc.add(SkipOnboardingEvent()),
                            child: Text(tr('onboarding_screen.skip')),
                          ),
                        ],
                      ),

                      Gap.gapH48,

                      BlocBuilder<OnboardingBloc, OnboardingState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: context.getHeight(multiplied: 0.67),
                            width: context.getWidth(),
                            child: PageView(
                              controller: onboardingBloc.pageController,
                              onPageChanged: (value) => onboardingBloc.currentIdex = value,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                OnboardingPageView(
                                  title: 'onboarding_screen.first_title',
                                  imagePath:
                                      'assets/onboarding/first_onboarding.png',
                                  body: 'onboarding_screen.first_body',
                                ),
                                OnboardingPageView(
                                  title: 'onboarding_screen.second_title',
                                  imagePath:
                                      'assets/onboarding/second_onboarding.png',
                                  body: 'onboarding_screen.second_body',
                                ),
                                OnboardingPageView(
                                  title: 'onboarding_screen.third_title',
                                  imagePath:
                                      'assets/onboarding/third_onboarding.png',
                                  body: 'onboarding_screen.third_body',
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      Spacer(),

                      BlocBuilder<OnboardingBloc, OnboardingState>(
                        builder: (context, state) {
                          return OnboardingIndictor(
                            currentIndex: onboardingBloc.currentIdex,
                          );
                        },
                      ),

                      Gap.gapH24,

                      BlocBuilder<OnboardingBloc, OnboardingState>(
                        builder: (context, state) {
                          return AppCustomButton(
                            label: onboardingBloc.currentIdex == 2
                                ? tr('onboarding_screen.get_started')
                                : tr('onboarding_screen.next'),
                            buttonColor: AppColors.primaryAppColor,
                            width: context.getWidth(),
                            height: context.getHeight(multiplied: 0.055),
                            onPressed: () {
                              onboardingBloc.add(
                                GoToNextPageEvent(
                                  index: onboardingBloc.currentIdex,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.title,
    required this.imagePath,
    required this.body,
  });

  final String title;
  final String imagePath;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.getHeight(multiplied: 0.05),
      children: [
        Text(tr(title), style: AppTextStyle.sfProBold24Onboarding),

        Image.asset(imagePath),

        Text(
          tr(body),
          style: AppTextStyle.sfProBold24Onboarding,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnboardingIndictor extends StatelessWidget {
  const OnboardingIndictor({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          width: 26,
          height: 6,
          duration: Duration(microseconds: 400),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.primaryAppColor
                : AppColors.onboardingSecondColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
