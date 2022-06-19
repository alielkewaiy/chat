import '../../../models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccessStates extends ShopRegisterStates {
  final LoginModel loginModel;
  ShopRegisterSuccessStates(this.loginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String? error;
  final LoginModel loginModel;
  ShopRegisterErrorStates(this.error, this.loginModel);
}

class ShopRegisterShowPasswordState extends ShopRegisterStates {}
