import 'package:shop_app_15_12/models/register_model.dart';
import 'package:shop_app_15_12/models/user_data.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterModel userData;
  RegisterSuccessState(this.userData);
}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}
