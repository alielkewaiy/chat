import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/shop_cubit.dart';
import '../layout/shop_states.dart';
import '../shared/componentes/components.dart';
import '../shared/componentes/constants.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).shopLoginModel;
        nameController.text = model!.data!.name!;
        emailController.text = model!.data!.email!;
        phoneController.text = model!.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).shopLoginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpDateUserStates)
                    LinearProgressIndicator(),
                  SizedBox(height: 30),
                  defaultTextFormField(
                      isPassword: false,
                      controller: nameController,
                      textInputType: TextInputType.text,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      isPassword: false,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                      isPassword: false,
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Phone';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  mainButton(
                      fontSize: 22,
                      text: 'UpData',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).upDataUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  mainButton(
                      fontSize: 22,
                      text: 'Logout',
                      function: () {
                        signOut(context);
                      })
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
