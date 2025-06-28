import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:halaqat_wasl_main_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_main_app/theme/app_color.dart';
import 'package:halaqat_wasl_main_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_main_app/ui/screens/edit_profile/edit_profile_screen.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/bloc/profile_bloc.dart';
import 'package:halaqat_wasl_main_app/ui/screens/profile/widgets/profile_item.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc()..add(ProfileDataLoadRequested()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      width: 150,
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 32.0,
                          bottom: 32.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, state){
                            if(state is ProfileData){

                              return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Profile',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.sfProBold24,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditProfileScreen()));
                                    },
                                    icon: Icon(LucideIcons.edit),
                                  ),
                                ],
                              ),
                              Expanded(child: ListView.builder(primary: false, itemCount: state.data.length, itemBuilder: (contex, index){
                                final item = state.data[index];
                                return ProfileItemWidget(item: item);
                              },),),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16.0,left: 8.0, right: 8.0 ),
                                child: ElevatedButton(

                                  onPressed: () {
                                    // context.read<AuthBloc>.add(LogoutEvent());

                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.cancelButtonColor,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.all(16.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.logout),
                                      Gap.gapW16,
                                      Text('Logout', style: AppTextStyle.sfProBold16),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                            }else if(state is ProfileLoading){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }else if(state is ProfileError){
                                return Center(child: Text(state.message),);
                            }else{
                              return Container();
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          );
        },
      ),
    );
  }
}
