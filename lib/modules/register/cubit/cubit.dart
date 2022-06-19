import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/register/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel shopLoginModel;

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      // print(value.data);
      shopLoginModel = LoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessStates(shopLoginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorStates(error.toString(), shopLoginModel));
    });
  }

  IconData icon = Icons.visibility_outlined;
  bool passwordShow = true;
  void showPassword() {
    passwordShow = !passwordShow;
    if (passwordShow) {
      icon = Icons.visibility_outlined;
    } else {
      icon = Icons.visibility_off;
    }
    emit(ShopRegisterShowPasswordState());
  }
}
