import 'package:shop_app_15_12/models/category_model.dart';
import 'package:shop_app_15_12/models/favourite_item_model.dart';
import 'package:shop_app_15_12/models/favourite_model.dart';
import 'package:shop_app_15_12/models/home_model.dart';
import 'package:shop_app_15_12/models/profile_model.dart';
import 'package:shop_app_15_12/models/user_data.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final HomeModel userData;

  HomeSuccessState(this.userData);
}

class ChangeIndexState extends HomeState {}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState(this.error);
}

class CategoryLoadingState extends HomeState {}

class CategorySuccessState extends HomeState {
  final CategoryModel categoryModel;

  CategorySuccessState(this.categoryModel);
}

class CategoryErrorState extends HomeState {
  final String error;

  CategoryErrorState(this.error);
}

class FavouriteSuccessState extends HomeState {
  final FavouriteModel favouriteModel;

  FavouriteSuccessState(this.favouriteModel);
}

class FavouritesErrorState extends HomeState {
  final String error;

  FavouritesErrorState(this.error);
}

class FavouriteItemsSuccessState extends HomeState {
  final FavouriteItemModel favouriteItemModel;

  FavouriteItemsSuccessState(this.favouriteItemModel);
}

class FavouritesItemErrorState extends HomeState {
  final String error;

  FavouritesItemErrorState(this.error);
}
