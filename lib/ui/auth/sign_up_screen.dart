import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/helpers/validator.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_custom_button.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_snack_bar.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/auth/auth_gate_screen.dart';
import 'package:halaqat_wasl_main_app/ui/auth/bloc/auth_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/auth/widgets/auth_text_field_with_label.dart';
import 'package:halaqat_wasl_main_app/ui/auth/widgets/gender_chip.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorState) {
          appSnackBar(
            context: context,
            message: state.errorMessage,
            isSuccess: false,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/auth/logo-halaqat-wasl.png'),

                Gap.gapH16,

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  width: context.getWidth(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('sign_up_screen.sign_up'),
                        style: AppTextStyle.sfProBold36,
                      ),

                      Gap.gapH8,

                      Text(
                        tr('sign_up_screen.sign_up_text'),
                        style: AppTextStyle.sfPro60014SecondaryTextColor,
                      ),

                      Gap.gapH16,

                      Form(
                        key: authBloc.signupFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            AuthTextFieldWithLabel(
                              label: tr('sign_up_screen.full_name'),
                              controller: authBloc.fullNameController,
                              onValidate: fullNameValidator,
                            ),

                            AuthTextFieldWithLabel(
                              label: tr('sign_up_screen.email'),
                              controller: authBloc.emailController,
                              onValidate: emailValidator,
                            ),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthTextFieldWithLabel(
                                  label: tr('sign_up_screen.password'),
                                  controller: authBloc.passwordController,
                                  isPassword: true,
                                  isShowPassword: authBloc.isShowPassword,
                                  onPressedToShowPasswordViability: () =>
                                      authBloc.add(
                                        TogglePasswordViabilityEvent(),
                                      ),
                                  onValidate: passwordValidator,
                                );
                              },
                            ),

                            AuthTextFieldWithLabel(
                              label: tr('sign_up_screen.phone_number'),
                              controller: authBloc.phoneNumberController,
                              isPhoneNumber: true,
                              onValidate: phoneValidator,
                            ),
                          ],
                        ),
                      ),

                      Gap.gapH24,

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Row(
                            spacing: 8,
                            children: [
                              GenderChip(
                                label: tr('sign_up_screen.male'),
                                genderIndex: 1,
                                selectedGender:
                                    authBloc.selectedGender == 'male' ? 1 : 2,
                                onPressed: () {
                                  authBloc.add(
                                    SelectedGenderEvent(genderIndex: 1),
                                  );
                                },
                              ),

                              GenderChip(
                                label: tr('sign_up_screen.female'),
                                genderIndex: 2,
                                selectedGender:
                                    authBloc.selectedGender == 'female' ? 2 : 1,
                                onPressed: () {
                                  authBloc.add(
                                    SelectedGenderEvent(genderIndex: 2),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),

                      Gap.gapH64,

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          String? label = tr('sign_up_screen.sign_up');
                          Widget? loading = CircularProgressIndicator(
                            color: Colors.white,
                          );
                          if (state is LoadingState) {
                            label = null;
                          }
                          return AppCustomButton(
                            label: label,
                            loading: loading,
                            buttonColor: AppColors.primaryButtonColor,
                            width: context.getWidth(),
                            height: context.getHeight(multiplied: 0.055),
                            onPressed: () async {
                              if (authBloc.signupFormKey.currentState!
                                  .validate()) {
                                authBloc.add(SignUpEvent());

                                await Future.delayed(
                                  Duration(milliseconds: 1400),
                                );
                                if (context.mounted) {
                                  context.moveToWithReplacement(
                                    context: context,
                                    screen: AuthGateScreen(),
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),

                      Gap.gapH24,

                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () => context.moveToWithReplacement(
                            context: context,
                            screen: BlocProvider(
                              create: (context) => AuthBloc(),
                              child: AuthGateScreen(whereYouWantToGo: 'log_in'),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: tr(
                                'sign_up_screen.already_have_an_account',
                              ),
                              style: AppTextStyle
                                  .sfPro20012, // Required for visibility
                              children: [
                                TextSpan(
                                  text: tr('sign_up_screen.log_in'),
                                  style: AppTextStyle.sfProPrimaryAppColor20012,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
