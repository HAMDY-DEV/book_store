import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/bottom_navigation_bar.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:book_store/features/auth/presentation/manager/auth_state.dart';
import 'package:book_store/features/auth/presentation/view/forget_password_view.dart';
import 'package:book_store/features/auth/presentation/view/signup_view.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessStat) {
            navigatorToAndRemoveUntil(context, const BottomNavBar());
          } else if (state is LoginErrorStat) {
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
                      const SizedBox(
                        height: 70,
                      ),
                      SvgPicture.asset(
                        'assets/svg/BookStoreLogo.svg',
                        width: 300,
                        height: 300,
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
                        obscureText: obscureText,
                        onTapVisibility: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter your password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            navigatorTo(context, const ForgetPasswordView());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: getBodyStyle(context,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Login',
                        onTap: () {
                          if (key.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                navigatorToReplacement(
                                    context, const SignupView());
                              },
                              child: Text(
                                'Signup',
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
