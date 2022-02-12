import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/shared_pref_helper.dart';
import 'package:shop_app_15_12/main.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_cubit.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_states.dart';
import 'package:shop_app_15_12/pages/login_register_pages/widgets/mytextformfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
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
        var cubit = LoginCubit.get(context);
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
                  "Login",
                  style: textStyleBig,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  controller: emailController,
                  hintText: "email",
                ),
                MyTextFormField(
                  controller: passController,
                  hintText: "password",
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      cubit.userLogin(
                          email: emailController.text,
                          password: passController.text);
                    },
                    child: Text("Login")),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("U don't have account ?")),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, registerScreen);
                            },
                            child: Container(
                              child: Text(
                                "Register Now",
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
