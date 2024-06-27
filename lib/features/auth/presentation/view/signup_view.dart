import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:book_store/features/auth/presentation/manager/auth_state.dart';
import 'package:book_store/features/auth/presentation/view/login_view.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;
  var key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessStat) {
            Navigator.pop(context);
            showRiveDialog(context: context, path: 'assets/riv/success.riv');

            Future.delayed(const Duration(seconds: 1), () {
              navigatorTo(context, const LoginView());
            });
          } else if (state is RegisterErrorStat) {
            Navigator.pop(context);
            showRiveDialog(context: context, path: 'assets/riv/error.riv');
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          } else {
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
                      SvgPicture.asset(
                        'assets/svg/BookStoreLogo.svg',
                        width: 300,
                        height: 300,
                      ),
                      CustomTextFormField(
                        label: 'Name',
                        controller: nameController,
                        hintText: 'Enter your name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Email',
                        controller: emailController,
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: PasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is Required';
                          }
                          return null;
                        },
                        obscureText: obscureTextPassword,
                        onTapVisibility: () {
                          setState(() {
                            obscureTextPassword = !obscureTextPassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        hintText: 'Enter your confirm password',
                        validator: (value) {
                          if (value!.isEmpty ||
                              value != PasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        obscureText: obscureTextConfirmPassword,
                        onTapVisibility: () {
                          setState(() {
                            obscureTextConfirmPassword =
                                !obscureTextConfirmPassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Signup',
                        onTap: () {
                          if (key.currentState!.validate()) {
                            context.read<AuthCubit>().signup(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: PasswordController.text,
                                  passwordConfirmation:
                                      confirmPasswordController.text,
                                );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account!'),
                          TextButton(
                              onPressed: () {
                                navigatorToReplacement(
                                    context, const LoginView());
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: AppColors.primaryColor),
                              ))
                        ],
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
