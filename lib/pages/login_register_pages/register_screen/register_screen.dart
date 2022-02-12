import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/shared_pref_helper.dart';
import 'package:shop_app_15_12/pages/login_register_pages/register_screen/cubit_register/register_cubit.dart';
import 'package:shop_app_15_12/pages/login_register_pages/register_screen/cubit_register/register_states.dart';
import 'package:shop_app_15_12/pages/login_register_pages/widgets/mytextformfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.userData.message!)));
          if (state.userData.status!) {
            debugPrint(state.userData.data!.token);
            SharedPrefHelper.putStr(
                    key: 'token', value: state.userData.data!.token)
                .then((value) {
              token = state.userData.data!.token;
              Navigator.pushReplacementNamed(context, mainScreen);
            });
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
              left: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "register",
                  style: textStyleBig,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  controller: nameController,
                  hintText: "name",
                ),
                MyTextFormField(
                  controller: emailController,
                  hintText: "email",
                ),
                MyTextFormField(
                  controller: passController,
                  hintText: "password",
                ),
                MyTextFormField(
                  controller: phoneController,
                  hintText: "phone",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        cubit.userRegister(
                            email: emailController.text,
                            password: passController.text,
                            name: nameController.text,
                            phone: phoneController.text);
                      },
                      child: Text("Register")),
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("U already have account ?")),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, loginScreen);
                            },
                            child: Container(
                              child: Text(
                                "Login Now",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
