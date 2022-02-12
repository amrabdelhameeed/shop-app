import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_cubit.dart';
import 'package:shop_app_15_12/pages/home_layout.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_cubit.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/login_screen.dart';
import 'package:shop_app_15_12/pages/login_register_pages/register_screen/cubit_register/register_cubit.dart';
import 'package:shop_app_15_12/pages/login_register_pages/register_screen/register_screen.dart';
import 'package:shop_app_15_12/pages/search_cubit/search_cubit.dart';
import 'package:shop_app_15_12/pages/search_screen.dart';

LoginCubit loginCubit = LoginCubit();

class AppRouter {
  HomeCubit? homeCubit;
  AppRouter() {
    homeCubit = HomeCubit()
      ..getHomeitems()
      ..getCategories()
      ..getFavourites();
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case mainScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()
              ..getHomeitems()
              ..getCategories()
              ..getFavourites(),
            child: HomeLayout(),
          );
        });
      case loginScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<LoginCubit>.value(
            value: loginCubit,
            child: LoginScreen(),
          );
        });
      case registerScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterScreen(),
          );
        });
      case searchScreen:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => SearchCubit(),
            child: SearchScreen(),
          );
        });
    }
  }
}
