import 'package:shop_app_15_12/models/profile_model.dart';
import 'package:shop_app_15_12/models/update_profile_model.dart';
import 'package:shop_app_15_12/models/user_data.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserData userData;

  LoginSuccessState(this.userData);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ProfileDataSuccessState extends LoginState {
  final ProfileModel profileModel;

  ProfileDataSuccessState(this.profileModel);
}

class ProfileDataErrorState extends LoginState {
  final String error;

  ProfileDataErrorState(this.error);
}

class UpdateUserSuccessState extends LoginState {
  final UserData updateProfileModel;
  UpdateUserSuccessState(this.updateProfileModel);
}

class LogoutUserErrorState extends LoginState {
  final String error;

  LogoutUserErrorState(this.error);
}

class UpdateUserErrorState extends LoginState {
  final String error;

  UpdateUserErrorState(this.error);
}
