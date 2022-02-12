import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/dio_helper.dart';
import 'package:shop_app_15_12/models/register_model.dart';
import 'package:shop_app_15_12/models/user_data.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_states.dart';
import 'package:shop_app_15_12/pages/login_register_pages/register_screen/cubit_register/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? userData;
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    DioHelper.init();
    emit(RegisterLoadingState());
    DioHelper.putData(
      token: token,
      url: register,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone
      },
    ).then((value) {
      userData = RegisterModel.fromJson(value.data);
      print(userData!.message);
      emit(RegisterSuccessState(userData!));
    }).catchError((error) {
      print(error.toString());

      emit(RegisterErrorState(error.toString()));
    });
  }
}
