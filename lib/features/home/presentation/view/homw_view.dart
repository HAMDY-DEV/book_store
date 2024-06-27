import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/cart/presentation/view/cart_view.dart';
import 'package:book_store/features/home/presentation/manager/home_cubit.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:book_store/features/home/presentation/widget/best_sellrey_view.dart';
import 'package:book_store/features/home/presentation/widget/categories.dart';
import 'package:book_store/features/home/presentation/widget/drawer.dart';
import 'package:book_store/features/home/presentation/widget/hader_home.dart';
import 'package:book_store/features/home/presentation/widget/new_arrivals.dart';
import 'package:book_store/features/home/presentation/widget/profile_home_view.dart';
import 'package:book_store/features/home/presentation/widget/smooth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:book_store/features/cart/model/cart_model.dart';

//import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  List<Widget> list = [
    const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            //profile
            ProfileHome(),
            //Hader
            HaderHome(),
            //Best Sellrey
            BestSellreyView(),
            //Carousel Slider
            SmoothPage(),
            //Categories
            CategoriesView(),
            //New Arrivals
            NewArrivals(),
          ],
        ),
      ),
    ),
    const CartView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getProfile()
        ..getSlider()
        ..getBastSellrey()
        ..getCategories()
        ..getNewArrivals()
        ..getCart(),
      child: Scaffold(
        drawer: Drawer(
          child: DrawerHome(),
        ),
        body: list[selectedIndex],
        floatingActionButton: selectedIndex == 1
            ? null
            : InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              CartModel? cartModel =
                                  HomeCubit.get(context).cartModel;

                              return cartModel != null &&
                                      cartModel.data!.cartItems!.isNotEmpty
                                  ? Container(
                                      alignment: Alignment.center,
                                      width: 13,
                                      height: 13,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        HomeCubit.get(context)
                                            .cartModel!
                                            .data!
                                            .cartItems!
                                            .length
                                            .toString(),
                                        style: getBodyStyle(context,
                                            color: AppColors.whiteColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
