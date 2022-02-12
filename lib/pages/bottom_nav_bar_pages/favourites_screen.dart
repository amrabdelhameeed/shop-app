import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_cubit.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        var cubit = HomeCubit.get(context);

        if (state is FavouriteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.favouriteModel.message!)));
          cubit.getFavourites();
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.favouriteItemModel != null
            ? SingleChildScrollView(
                child: Column(
                children: [
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cubit.favouriteItemModel!.data!
                                        .favouriteData[index].product!.image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 50,
                                    color: Colors.white,
                                    child: Text(
                                      cubit.favouriteItemModel!.data!
                                          .favouriteData[index].product!.name,
                                      style: TextStyle(fontSize: 19),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 50,
                                    color: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.toggleFavourite(cubit
                                            .favouriteItemModel!
                                            .data!
                                            .favouriteData[index]
                                            .product!
                                            .id!);
                                      },
                                      icon: Icon(Icons.favorite),
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 15,
                        );
                      },
                      itemCount:
                          cubit.favouriteItemModel!.data!.favouriteData.length)
                ],
              ))
            : Center(
                child: Text("No Favourites"),
              );
      },
    );
  }
}
