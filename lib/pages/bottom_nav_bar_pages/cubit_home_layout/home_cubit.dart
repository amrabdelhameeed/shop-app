import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/cores/dio_helper.dart';
import 'package:shop_app_15_12/models/category_model.dart';
import 'package:shop_app_15_12/models/favourite_item_model.dart';
import 'package:shop_app_15_12/models/favourite_model.dart';
import 'package:shop_app_15_12/models/home_model.dart';
import 'package:shop_app_15_12/models/profile_model.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/categories_screen.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_states.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/favourites_screen.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/products_screen.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/settings_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int curIndex = 0;
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  FavouriteModel? favouriteModel;
  FavouriteItemModel? favouriteItemModel;
  void changeIndex(int index) {
    if (homeModel != null && categoryModel != null) curIndex = index;
    if (index == 2) {
      getFavourites();
    }
    emit(ChangeIndexState());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];
  List<String> screensLabels = [
    "ProductsScreen",
    "CategoriesScreen",
    "FavouritesScreen",
    "SettingsScreen"
  ];
  Map<int, bool> favourites = {};

  void getHomeitems() {
    emit(HomeLoadingState());
    DioHelper.init();
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      favourites = {};
      homeModel!.homeData!.products!.forEach((e) {
        favourites.addAll({e.id: e.inFavorites});
      });
      print(favourites[53]);
      print(token);

      emit(HomeSuccessState(homeModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }

  void getCategories() {
    emit(CategoryLoadingState());
    DioHelper.init();
    DioHelper.getData(url: categories, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(CategorySuccessState(categoryModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CategoryErrorState(error.toString()));
    });
  }

  void getFavourites() {
    DioHelper.init();
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      favouriteItemModel = FavouriteItemModel.fromJson(value.data);
      if (favouriteItemModel!.data!.favouriteData.isEmpty) {
        favouriteItemModel = null;
      }
      emit(FavouriteItemsSuccessState(favouriteItemModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      favouriteItemModel = null;
      emit(FavouritesItemErrorState(error.toString()));
    });
  }

  void toggleFavourite(int id) {
    emit(CategoryLoadingState());
    DioHelper.init();
    DioHelper.putData(url: favorites, token: token, data: {"product_id": id})
        .then((value) {
      //  categoryModel = CategoryModel.fromJson(value.data);
      favouriteModel = FavouriteModel.fromJson(value.data);
      if (favouriteModel!.status!) {
        favourites[id] = !favourites[id]!;
      }
      emit(FavouriteSuccessState(favouriteModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(FavouritesErrorState(error.toString()));
    });
  }
}
