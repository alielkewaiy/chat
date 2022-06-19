import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool showPassword = true;
  IconData icon = Icons.visibility;

  void changePassword() {
    showPassword = !showPassword;
    if (showPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(LoginChangePassword());
  }

  late LoginModel loginModel;
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'login',
        data: {'email': email, 'password': password}).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString(), loginModel));
    });
  }
}
