import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pro/layout/shop_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../layout/home_layout.dart';
import '../../shared/componentes/components.dart';
import '../../shared/componentes/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKry = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessStates) {
              if (state.loginModel.status) {
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data?.token)
                    .then((value) {
                  token = state.loginModel.data?.token;
                  ShopCubit.get(context).getUserData();
                  ShopCubit.get(context).getFavorites();

                  navigateAndFinish(context, HomeLayout());
                });
              }
            }
            if (state is ShopRegisterErrorStates) {
              print(state.loginModel.message);
              showToast(
                  message: state.loginModel.message!,
                  states: ToastStates.ERROR);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,

                  statusBarIconBrightness:
                      Brightness.light, // For Android (dark icons)
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Form(
                      key: formKry,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'Register to brows ours hot offers ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                              isPassword: false,
                              controller: nameController,
                              textInputType: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Name Address';
                                } else {
                                  return null;
                                }
                              },
                              label: ' Name',
                              prefix: Icons.person),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                              isPassword: false,
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Email Address';
                                } else {
                                  return null;
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                              controller: passwordController,
                              textInputType: TextInputType.visiblePassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is too short';
                                } else {
                                  return null;
                                }
                              },
                              isPassword:
                                  ShopRegisterCubit.get(context).passwordShow,
                              label: 'Password',
                              prefix: Icons.lock_outlined,
                              suffix: ShopRegisterCubit.get(context).icon,
                              showPassword: () {
                                ShopRegisterCubit.get(context).showPassword();
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                              isPassword: false,
                              controller: phoneController,
                              textInputType: TextInputType.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Phone Address';
                                } else {
                                  return null;
                                }
                              },
                              label: 'Phone',
                              prefix: Icons.phone),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingStates,
                              builder: (context) => mainButton(
                                  text: 'Register',
                                  function: () {
                                    if (formKry.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .userRegister(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text);
                                    }
                                  }),
                              fallback: (context) => Center(
                                    child: CircularProgressIndicator(),
                                  )),
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
