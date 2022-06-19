import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/shop_cubit.dart';
import '../layout/shop_states.dart';
import '../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data!.data.length);
        });
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 20),
            Text(
              '${model.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
