import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/view/login_view.dart';
import 'package:book_store/features/home/model/profile_model/profile_model.dart';
import 'package:book_store/features/home/presentation/manager/home_cubit.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:book_store/features/order_histoey/presentation/view/order_histoey_view.dart';
import 'package:book_store/features/update-password/presentation/view/update-password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class DrawerHome extends StatelessWidget {
  DrawerHome({super.key});
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        ProfileModel? profile = HomeCubit.get(context).profileModel;
        return profile != null
            ? Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    color: AppColors.primaryColor,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 20,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(profile.data!.image!),
                          ),
                        ),
                        Positioned(
                          top: 115,
                          left: 20,
                          child: Text(
                            profile.data!.name!,
                            style: getBodyStyle(context,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          top: 140,
                          left: 20,
                          child: Text(
                            profile.data!.email!,
                            style: getSmallStyle(context,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      navigatorTo(context, const OrderHistoeyView());
                    },
                    title: Text(
                      'Order History',
                      style: getBodyStyle(context,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading:
                        Icon(Icons.history_edu, color: AppColors.primaryColor),
                  ),
                  const Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                  ListTile(
                    onTap: () {
                      navigatorTo(context, const UpdatePassword());
                    },
                    title: Text(
                      'Change Password',
                      style: getBodyStyle(context,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading:
                        Icon(Icons.password, color: AppColors.primaryColor),
                  ),
                  const Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Delete Account',
                              style: getTitleStyle(context,
                                  color: AppColors.primaryColor),
                            ),
                            content: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  label: Text(
                                'Enter your password',
                                style: getSmallStyle(context,
                                    color: AppColors.primaryColor),
                              )),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primaryColor),
                                child: const Text("Delete Account"),
                                onPressed: () {
                                  DioHelper.postData(
                                      url: 'delete-profile',
                                      data: {
                                        'current_password':
                                            passwordController.text
                                      }).then((value) {
                                    showRiveDialog(
                                        context: context,
                                        path: 'assets/riv/success.riv');
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Token.removeToken();
                                      navigatorToAndRemoveUntil(
                                          context, LoginView);
                                    });
                                  }).catchError((onError) {
                                    showRiveDialog(
                                        context: context,
                                        path: 'assets/riv/error.riv');
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      Navigator.pop(context);
                                    });
                                  });
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primaryColor),
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(
                      'Delete Account',
                      style: getBodyStyle(context,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.delete, color: AppColors.primaryColor),
                  ),
                  const Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                  ListTile(
                    onTap: () {
                      DioHelper.postData(url: 'logout').then((value) {
                        Token.removeToken();
                        navigatorToAndRemoveUntil(context, const LoginView());
                      });
                    },
                    title: Text(
                      'LogOut',
                      style: getBodyStyle(context,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(Icons.logout, color: AppColors.primaryColor),
                  ),
                  const Divider(
                    endIndent: 20,
                    indent: 20,
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
