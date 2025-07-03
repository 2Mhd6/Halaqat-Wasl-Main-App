import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_main_app/extensions/nav.dart';
import 'package:halaqat_wasl_main_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_custom_button.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/app_snack_bar.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_colors.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/auth/auth_gate_screen.dart';
import 'package:halaqat_wasl_main_app/ui/auth/bloc/auth_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/auth/sign_up_screen.dart';
import 'package:halaqat_wasl_main_app/ui/auth/widgets/auth_text_field_with_label.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorState) {
          appSnackBar(context: context,message: state.errorMessage,isSuccess: false);
        } 
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap.gapH32,

                Image.asset('assets/auth/logo-halaqat-wasl.png'),

                Gap.gapH24,

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  width: context.getWidth(),
                  height: context.getHeight(multiplied: 0.76),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('log_in_screen.login'),
                        style: AppTextStyle.sfProBold36,
                      ),

                      Gap.gapH8,

                      Text(
                        tr('log_in_screen.log_in_text'),
                        style: AppTextStyle.sfPro60014SecondaryTextColor,
                      ),

                      Gap.gapH24,

                      Form(
                        key: authBloc.loginFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            AuthTextFieldWithLabel(
                              label: tr('log_in_screen.email'),
                              controller: authBloc.emailController,
                            ),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return AuthTextFieldWithLabel(
                                  label: tr('log_in_screen.password'),
                                  controller: authBloc.passwordController,
                                  isPassword: true,
                                  isShowPassword: authBloc.isShowPassword,
                                  onPressedToShowPasswordViability: () =>authBloc.add(TogglePasswordViabilityEvent()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      Gap.gapH16,

                      SizedBox(
                        width: context.getWidth(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Forget your password?',
                                style:
                                    AppTextStyle.sfProForgetPasswordColor20012,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          String? label = tr('log_in_screen.login');
                          Widget? loading =CircularProgressIndicator(color: Colors.white);
                          if(state is LoadingState){
                            label = null;
                          }
                          return AppCustomButton(
                            label: label,
                            loading: loading,
                            buttonColor: AppColors.primaryButtonColor,
                            width: context.getWidth(),
                            height: context.getHeight(multiplied: 0.055),
                            onPressed: () async {
                              if(authBloc.loginFormKey.currentState!.validate()){
                                
                                authBloc.add(LogInEvent());
                                
                                await Future.delayed(Duration(milliseconds: 800));
                                
                                if(context.mounted){
                                  context.moveToWithReplacement(context: context, screen: AuthGateScreen());
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
                            screen: SignUpScreen(),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: tr('log_in_screen.don’t_have_an_account'),
                              style: AppTextStyle
                                  .sfPro20012, // Required for visibility
                              children: [
                                TextSpan(
                                  text: tr('log_in_screen.sign_up'),
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
