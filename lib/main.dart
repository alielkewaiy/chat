import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/shared/bloc_observer.dart';
import 'package:shop_pro/shared/componentes/constants.dart';
import 'package:shop_pro/shared/network/local/cache_helper.dart';
import 'package:shop_pro/shared/network/remote/dio_helper.dart';

import 'layout/home_layout.dart';
import 'layout/shop_cubit.dart';
import 'layout/shop_states.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_borading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? onBoard = CacheHelper.getData(key: 'onBoard');
  token = CacheHelper.getData(key: 'token');
  Widget widget;
  if (onBoard != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(this.widget); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()
          ..getHomeData()
          ..getFavorites()
          ..getCategories()
          ..getUserData(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: widget,
            );
          },
        ));
  }
}
