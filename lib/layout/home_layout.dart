import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/layout/shop_cubit.dart';
import 'package:shop_pro/layout/shop_states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("shop"),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,

              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeScreen(index);
            },
            items: cubit.itemBottom,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
          ),
        );
      },
    );
  }
}
