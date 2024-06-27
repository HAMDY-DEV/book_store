import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:book_store/features/auth/presentation/manager/auth_state.dart';
import 'package:book_store/features/auth/presentation/view/reset_password_view.dart';
import 'package:book_store/features/auth/presentation/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
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
          if (state is ForgetPasswordSuccessStat) {
            Navigator.pop(context);
            showRiveDialog(context: context, path: 'assets/riv/success.riv');
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          } else if (state is ForgetPasswordErrorStat) {
            Navigator.pop(context);
            showRiveDialog(context: context, path: 'assets/riv/error.riv');
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          } else if (state is ForgetPasswordLoadingStat) {
            showRiveDialog(
                context: context, path: 'assets/riv/loading_book.riv');
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
                      CustomButton(
                        text: 'Send',
                        onTap: () {
                          if (key.currentState!.validate()) {
                            context.read<AuthCubit>().forgotPassword(
                                  email: emailController.text,
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
                                    context, const ResetPasswordView());
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
