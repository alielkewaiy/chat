import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/shop_cubit.dart';
import '../layout/shop_states.dart';
import '../models/get_favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => favoriteItem(
                    ShopCubit.get(context).getFavoritesModel!.data!.data[index],
                    context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: Colors.grey,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                itemCount: ShopCubit.get(context)
                    .getFavoritesModel!
                    .data!
                    .data
                    .length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget favoriteItem(DataProducts? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model!.data!.image}'),
                  height: 200,
                  width: 200,
                ),
                if (model.data!.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.data!.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.data!.price}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.data!.id);
                            //print(model.id);
                          },
                          icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .favoritesList[model.data!.id]!
                                  ? Colors.blue
                                  : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
