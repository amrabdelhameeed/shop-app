import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_cubit.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var list = cubit.categoryModel!.dataAll.dataList;
        return SingleChildScrollView(
          child: Column(children: [
            Container(
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(list[index].image),
                              scale: 0.4,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Text(list[index].name),
                      ),
                    ]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 5,
                    );
                  },
                  itemCount: cubit.categoryModel!.dataAll.dataList.length),
            )
          ]),
        );
      },
    );
  }
}
