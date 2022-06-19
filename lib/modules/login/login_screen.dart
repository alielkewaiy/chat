import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/modules/register/shop_register_scrren.dart';
import 'package:sizer/sizer.dart';

import '../../layout/home_layout.dart';
import '../../layout/shop_cubit.dart';
import '../../shared/componentes/components.dart';
import '../../shared/componentes/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.loginModel.status) {
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data!.token)
                    .then((value) {
                  token = state.loginModel.data!.token;
                  ShopCubit.get(context).getUserData();
                  ShopCubit.get(context).getFavorites();
                  navigateAndFinish(context, HomeLayout());
                });
              } else {
                showToast(
                    message: state.loginModel.message!,
                    states: ToastStates.ERROR);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'login to brows ours hot offers',
                            style:
                                TextStyle(fontSize: 19.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          defaultTextFormField(
                              isPassword: false,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Email';
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                              label: 'Email',
                              prefix: Icons.email),
                          SizedBox(
                            height: 2.h,
                          ),
                          defaultTextFormField(
                              showPassword: () {
                                LoginCubit.get(context).changePassword();
                              },
                              isPassword: LoginCubit.get(context).showPassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordController,
                              textInputType: TextInputType.visiblePassword,
                              label: 'Password',
                              prefix: Icons.lock_outline_rounded,
                              suffix: LoginCubit.get(context).icon),
                          SizedBox(
                            height: 3.5.h,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => mainButton(
                                  text: 'Login',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  }),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator())),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              defaultTextButton(
                                  text: 'Register ',
                                  function: () {
                                    navigateTo(context, ShopRegisterScreen());
                                  },
                                  fontSize: 16.sp),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
