import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_15_12/pages/login_register_pages/widgets/mytextformfield.dart';
import 'package:shop_app_15_12/pages/search_cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearchCubit.get(context);

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Search"),
              backgroundColor: Colors.teal,
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: TextFormField(
                      onChanged: (v) {
                        cubit.searchFunc(v);
                      },
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: "Search", border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 15),
                  cubit.searchModel != null && controller.text.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(cubit.searchModel!
                                              .data.data[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.white,
                                      child: Text(
                                        cubit
                                            .searchModel!.data.data[index].name,
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 15,
                                );
                              },
                              itemCount: cubit.searchModel!.data.data.length),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
