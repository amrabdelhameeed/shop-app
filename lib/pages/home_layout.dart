import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_cubit.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    cubit.curIndex = 0;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.teal.shade300,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, searchScreen);
                  },
                  icon: Icon(Icons.search))
            ],
            backgroundColor: Colors.teal,
            title: Text(cubit.screensLabels[cubit.curIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.teal,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.production_quantity_limits,
                  ),
                  label: "Products"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                  ),
                  label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                  ),
                  label: "Favourites"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: "Settings"),
            ],
            currentIndex: cubit.curIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
          body: cubit.screens[cubit.curIndex],
        );
      },
    );
  }
}
