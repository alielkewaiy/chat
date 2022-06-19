import '../models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopLoadingGetHomeDataState extends ShopStates {}

class ShopSuccessGetHomeDataState extends ShopStates {}

class ShopErrorGetHomeDataState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingUpDateUserStates extends ShopStates {}

class ShopLoadingUserDataStates extends ShopStates {}

class ShopErrorUserDataStates extends ShopStates {}

class ShopErrorUpDateUserStates extends ShopStates {}

class ShopSuccessUpDateUserStates extends ShopStates {
  LoginModel? shopLoginModel;
  ShopSuccessUpDateUserStates(this.shopLoginModel);
}

class ShopSuccessUserDataStates extends ShopStates {
  LoginModel? shopLoginModel;
  ShopSuccessUserDataStates(this.shopLoginModel);
}

class ShopLoadingCategoriesStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}
