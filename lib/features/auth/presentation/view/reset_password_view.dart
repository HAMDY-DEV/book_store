import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:book_store/features/auth/presentation/manager/auth_state.dart';
import 'package:book_store/features/auth/presentation/view/login_view.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  bool obscureText = true;
  TextEditingController codeController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessStat) {
            Navigator.pop(context);
            showRiveDialog(context: context, path: 'assets/riv/success.riv');
            Future.delayed(const Duration(seconds: 1), () {
              navigatorToAndRemoveUntil(context, const LoginView());
            });
          } else if (state is ResetPasswordErrorStat) {
            Navigator.pop(context);
            showRiveDialog(context: context, path: 'assets/riv/error.riv');
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          } else if (state is ResetPasswordLoadingStat) {
            showLoading(context: context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: key,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      SvgPicture.asset(
                        'assets/svg/BookStoreLogo.svg',
                        width: 300,
                        height: 300,
                      ),
                      CustomTextFormField(
                        label: 'Code',
                        keyboardType: TextInputType.number,
                        controller: codeController,
                        hintText: 'Enter your code',
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
                        label: 'New Password',
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
                        text: 'Save',
                        onTap: () {
                          if (key.currentState!.validate()) {
                            context.read<AuthCubit>().resetPassword(
                                  code: codeController.text,
                                  password: passwordController.text,
                                  passwordConfirmation:
                                      confirmPasswordController.text,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
