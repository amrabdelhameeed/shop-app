import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/dio_helper.dart';
import 'package:shop_app_15_12/models/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  Search? searchModel;
  void searchFunc(String text) {
    DioHelper.init();
    DioHelper.putData(url: search, token: token, data: {"text": text})
        .then((value) {
      searchModel = Search.fromJson(value.data);
      emit(SearchSuccess(searchModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      searchModel = null;
      emit(SearchError(error.toString()));
    });
  }
}
