import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/layout/shop_states.dart';

import '../models/categories_model.dart';
import '../models/change_favorites_model.dart';
import '../models/get_favorites_model.dart';
import '../models/home_nodel.dart';
import '../models/login_model.dart';
import '../modules/categories_screen.dart';
import '../modules/favorites_screen.dart';
import '../modules/products_screen.dart';
import '../modules/settings_screen.dart';
import '../shared/componentes/constants.dart';
import '../shared/end_points.dart';
import '../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  Map<int?, bool?> favoritesList = {};
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> itemBottom = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingGetHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.formJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favoritesList.addAll({element.id: element.inFavorites});
      });

      print(homeModel!.data!.products[1].name);
      print(homeModel!.data!.products[1].images[1]);
      emit(ShopSuccessGetHomeDataState());
    }).catchError((error) {
      print(token);
      emit(ShopErrorGetHomeDataState());
    });
  }

  GetFavorites? getFavoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      getFavoritesModel = GetFavorites.froJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ChangeFavorites? changeFavoritesModel;
  void changeFavorites(int? productId) {
    favoritesList[productId] = !favoritesList[productId]!;
    emit(ShopLoadingChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavorites.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favoritesList[productId] = !favoritesList[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favoritesList[productId] = !favoritesList[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  LoginModel? shopLoginModel;
  void getUserData() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopLoginModel = LoginModel.fromJson(value.data);
      print(shopLoginModel!.data!.name.toString());
      print('88888888888888888888888888888888');
      emit(ShopSuccessUserDataStates(shopLoginModel));
    }).catchError((error) {
      emit(ShopErrorUserDataStates());
    });
  }

  void upDataUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpDateUserStates());
    DioHelper.putData(url: UPDATE_PROFILE, authorization: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      print(token);
      shopLoginModel = LoginModel.fromJson(value.data);
      print(shopLoginModel!.data!.name.toString());
      print('88888888888888888888888888888888');
      emit(ShopSuccessUpDateUserStates(shopLoginModel));
    }).catchError((error) {
      print(error.toString());
      print(token);
      emit(ShopErrorUpDateUserStates());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(ShopLoadingCategoriesStates());

    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      emit(ShopErrorCategoriesStates());
    });
  }
}
