import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:book_store/features/update-password/presentation/manager/update_password_cubit.dart';
import 'package:book_store/features/update-password/presentation/manager/update_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool obscureText = true;
  TextEditingController currentController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Password',
          style: getTitleStyle(
            context,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => UpdatePasswordCubit(),
        child: Form(
          key: key,
          child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
            listener: (context, state) {
              if (state is UpdatePasswordSuccess) {
                Navigator.pop(context);
                showRiveDialog(
                    context: context, path: 'assets/riv/success.riv');
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              } else if (state is UpdatePasswordLoading) {
                showLoading(context: context);
              } else if (state is UpdatePasswordError) {
                Navigator.pop(context);
                showRiveDialog(context: context, path: 'assets/riv/error.riv');
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                });
              }
            },
            builder: (context, state) {
              var cubit = UpdatePasswordCubit.get(context);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        CustomTextFormField(
                          label: 'Current Password',
                          keyboardType: TextInputType.number,
                          controller: currentController,
                          hintText: 'Enter your current password',
                          obscureText: obscureText,
                          onTapVisibility: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Code is Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          obscureText: obscureText,
                          onTapVisibility: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          controller: passwordController,
                          label: 'New Password',
                          hintText: 'Enter the new password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          obscureText: obscureText,
                          onTapVisibility: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          controller: confirmPasswordController,
                          label: 'Confirm Password',
                          hintText: 'Enter your confirm password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'Change Password',
                          onTap: () {
                            if (key.currentState!.validate()) {
                              cubit.updatePassword(
                                current_password: currentController.text,
                                new_password: passwordController.text,
                                new_password_confirmation:
                                    confirmPasswordController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
