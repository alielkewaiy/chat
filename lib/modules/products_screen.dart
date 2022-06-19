import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../layout/shop_cubit.dart';
import '../layout/shop_states.dart';
import '../models/home_nodel.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel, context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model, context) =>
      Sizer(builder: (context, orientation, deviceType) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: model!.data!.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 25.h,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(
                height: 3.h,
              ),
              Column(
                children: [
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 1 / .33.h,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                          model.data!.products.length,
                          (index) => buildGridProduct(
                              model.data!.products[index], context)),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });

  Widget buildGridProduct(Products? model, context) => Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage('${model!.image}'),
                    height: 26.h,
                    width: double.infinity,
                  ),
                  if (model.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 1.h),
                      color: Colors.red,
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text('${model.name}'),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    width: 2.h,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 8.sp),
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                        //print(model.id);
                      },
                      icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favoritesList[model.id]!
                                  ? Colors.blue
                                  : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )))
                ],
              ),
            ],
          ),
        ),
      );
}
