import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/app_router.dart';
import 'package:shop_app_15_12/constants/observer.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/dio_helper.dart';
import 'package:shop_app_15_12/cores/shared_pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  DioHelper.init();
  token = SharedPrefHelper.getStr(key: 'token');
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      initialRoute: token == "" ? loginScreen : mainScreen,
      onGenerateRoute: appRouter.generateRoutes,
    );
  }
}
