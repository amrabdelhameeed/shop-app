import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/dio_helper.dart';
import 'package:shop_app_15_12/cores/shared_pref_helper.dart';
import 'package:shop_app_15_12/models/profile_model.dart';
import 'package:shop_app_15_12/models/update_profile_model.dart';
import 'package:shop_app_15_12/models/user_data.dart';
import 'package:shop_app_15_12/pages/login_register_pages/login_screen/cubit_login/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserData? userData;
  ProfileModel? profileModel;
  UpdateProfileModel? updateProfileModel;
  void userLogin({required String email, required String password}) {
    DioHelper.init();
    emit(LoginLoadingState());
    DioHelper.putData(
      url: login,
      token: token,
      data: {'email': email, 'password': password},
    ).then((value) {
      userData = UserData.fromJson(value.data);
      token = userData!.data!.token;
      SharedPrefHelper.putStr(key: 'token', value: token);
      print("Token Saved :) :$token");
      emit(LoginSuccessState(userData!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  void getProfileData() {
    DioHelper.init();
    DioHelper.getData(url: profile, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ProfileDataSuccessState(profileModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ProfileDataErrorState(error.toString()));
    });
  }

  void updateProfileData(
      {required String email, required String name, required String phone}) {
    DioHelper.init();
    DioHelper.realPutData(
        url: updateProfile,
        token: token,
        data: {'name': name, 'phone': phone, 'email': email}).then((value) {
      userData = UserData.fromJson(value.data);
      emit(UpdateUserSuccessState(userData!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UpdateUserErrorState(error.toString()));
    });
  }

  void logoutUser() {
    DioHelper.init();
    DioHelper.putData(url: logout, token: token, data: {}).then((value) {
      SharedPrefHelper.putStr(key: 'token', value: "");
      token = "";
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LogoutUserErrorState(error.toString()));
    });
  }
}
