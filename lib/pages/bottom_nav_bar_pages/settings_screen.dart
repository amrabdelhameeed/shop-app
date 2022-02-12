import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/app_router.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/shared_pref_helper.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_cubit.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_states.dart';
import 'package:shop_app_15_12/pages/login_register_pages/widgets/mytextformfield.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>.value(
      value: loginCubit..getProfileData(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          var cubit = LoginCubit.get(context);
          if (state is UpdateUserSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.updateProfileModel.message!)));
            cubit.getProfileData();
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return cubit.profileModel != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Profile Information",
                        style: textStyleBig,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField(
                        controller: nameController
                          ..text = cubit.profileModel!.profileModelData.name,
                        hintText: "name",
                      ),
                      MyTextFormField(
                        controller: emailController
                          ..text = cubit.profileModel!.profileModelData.email,
                        hintText: "email",
                      ),
                      MyTextFormField(
                        controller: phoneController
                          ..text = cubit.profileModel!.profileModelData.phone,
                        hintText: "phone",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.teal.shade800),
                            onPressed: () {
                              cubit.updateProfileData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);
                            },
                            child: Text("Update Your Data",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.teal.shade800),
                            onPressed: () {
                              cubit.logoutUser();
                              Navigator.pushReplacementNamed(
                                  context, loginScreen);
                              token = "";
                              SharedPrefHelper.putStr(key: 'token', value: "");
                            },
                            child: Text("Logout",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ));
        },
      ),
    );
  }
}
