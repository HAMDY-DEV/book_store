import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/core/widget/bottom_navigation_bar.dart';
import 'package:book_store/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplshView extends StatefulWidget {
  const SplshView({super.key});

  @override
  State<SplshView> createState() => _SplshViewState();
}

class _SplshViewState extends State<SplshView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigatorToReplacement(context,
          Token.getToken() == null ? const LoginView() : const BottomNavBar());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/svg/BookStoreLogo.svg'),
      ),
    );
  }
}
