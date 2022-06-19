import 'package:shop_pro/shared/componentes/components.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';

String? token;
void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}
