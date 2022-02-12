import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app_15_12/constants/strings.dart';
import 'package:shop_app_15_12/models/category_model.dart';
import 'package:shop_app_15_12/models/home_model.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_cubit.dart';
import 'package:shop_app_15_12/pages/bottom_nav_bar_pages/cubit_home_layout/home_states.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  List<Products> products = [];
  List<Banners> banners = [];
  List<DataCategory> categories = [];
  Map<int, bool> favouriotesList = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        var cubit = HomeCubit.get(context);

        if (state is HomeSuccessState) {
          products = state.userData.homeData!.products!;
          banners = state.userData.homeData!.banners!;
          favouriotesList = cubit.favourites;
        }
        if (state is CategorySuccessState) {
          categories = state.categoryModel.dataAll.dataList;
        }
        if (state is FavouriteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.favouriteModel.message!)));
          cubit.getFavourites();
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return products.isNotEmpty &&
                banners.isNotEmpty &&
                categories.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: CarouselSlider.builder(
                          itemCount: cubit.homeModel!.homeData!.banners!.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(cubit.homeModel!
                                        .homeData!.banners![index].image),
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              initialPage: 0,
                              autoPlay: true,
                              height: 200,
                              enableInfiniteScroll: false,
                              autoPlayInterval: Duration(seconds: 4),
                              autoPlayAnimationDuration: Duration(seconds: 1))),
                    ),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          cubit.categoryModel!.dataAll.dataList.isNotEmpty,
                      fallbackBuilder: (context) => CircularProgressIndicator(),
                      widgetBuilder: (context) => Container(
                        height: 200,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          cubit.categoryModel!.dataAll
                                              .dataList[index].image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: 150,
                                    child: Text(cubit.categoryModel!.dataAll
                                        .dataList[index].name),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            },
                            itemCount:
                                cubit.categoryModel!.dataAll.dataList.length),
                      ),
                    ),
                    Container(
                        child: GridView.count(
                      childAspectRatio: 1 / 1.3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                          cubit.homeModel!.homeData!.products!.length, (index) {
                        return myGridTile(
                            context, index, cubit, favouriotesList);
                      }),
                    ))
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

Widget myGridTile(BuildContext context, int index, HomeCubit cubit,
    Map<int, bool> favouriotesList) {
  return GridTile(
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.all(3),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    cubit.homeModel!.homeData!.products![index].image),
                fit: BoxFit.cover),
          ),
        ),
        cubit.homeModel!.homeData!.products![index].discount != 0
            ? Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Text(
                      cubit.homeModel!.homeData!.products![index].discount
                              .toString() +
                          "%",
                      style: TextStyle(color: Colors.white),
                    )))
            : Container(),
        cubit.homeModel!.homeData!.products![index].discount != 0
            ? Positioned(
                top: 10,
                left: 10,
                child: Container(
                  color: Colors.white,
                  child: Text(
                    "Discount ".toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ))
            : Container(),
      ],
    ),
    footer: Container(
        margin: EdgeInsets.only(left: 3, right: 3),
        height: 80,
        color: Colors.teal.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cubit.homeModel!.homeData!.products![index].name,
              maxLines: 2,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "price : " +
                        cubit.homeModel!.homeData!.products![index].price
                            .toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.toggleFavourite(
                          cubit.homeModel!.homeData!.products![index].id);
                    },
                    icon: Icon(cubit.favourites[cubit
                                .homeModel!.homeData!.products![index].id] ==
                            true
                        ? Icons.favorite
                        : Icons.favorite_outline),
                    color: Colors.black,
                  ),
                  Text(
                    "" +
                        cubit.homeModel!.homeData!.products![index].oldPrice
                            .toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ),
          ],
        )),
  );
}
/*
ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 150,
                            width: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(cubit.homeModel!.homeData!
                                      .banners![index].image),
                                  fit: BoxFit.cover),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: cubit.homeModel!.homeData!.banners!.length)
 */

/*
Container(
                        child: GridView.count(
                      childAspectRatio: 1 / 1.3,
                      scrollDirection: Axis.horizontal,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      crossAxisCount: 1,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: List.generate(
                          cubit.categoryModel!.data!.dataInside.length,
                          (index) {
                        return Container(
                          margin: EdgeInsets.all(3),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  cubit.categoryModel!.data!.dataInside[index]
                                      .image,
                                ),
                                fit: BoxFit.cover),
                          ),
                        );
                      }),
                    ))

 */
