import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/bottom_navigation_bar.dart';
import 'package:book_store/core/widget/shmmer_list_itma.dart';
import 'package:book_store/features/cart/model/cart_model.dart';
import 'package:book_store/features/cart/presentation/manager/cart_cubit.dart';
import 'package:book_store/features/cart/presentation/manager/cart_cubit_state.dart';
import 'package:book_store/features/cart/presentation/widget/list_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          CartModel? cartModel = CartCubit.get(context).cartModel;
          return cartModel != null
              ? Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      'Cart',
                      style: getTitleStyle(context),
                    ),
                    leading: IconButton(
                        onPressed: () {
                          navigatorToAndRemoveUntil(
                              context, const BottomNavBar());
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  body:
                      CartCubit.get(context).cartModel!.data!.cartItems!.isEmpty
                          ? Center(
                              child: SvgPicture.asset(
                                'assets/svg/undraw_empty_cart_co35.svg',
                                width: double.infinity,
                                height: 300,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return ListCart(
                                  itemProductName: cartModel
                                      .data!.cartItems![index].itemProductName
                                      .toString(),
                                  itemProductImage: cartModel
                                      .data!.cartItems![index].itemProductImage
                                      .toString(),
                                  itemProductDiscount: cartModel.data!
                                      .cartItems![index].itemProductDiscount
                                      .toString(),
                                  item_product_price: cartModel
                                      .data!.cartItems![index].itemProductPrice
                                      .toString(),
                                  item_product_price_after_discount: cartModel
                                      .data!
                                      .cartItems![index]
                                      .itemProductPriceAfterDiscount
                                      .toString(),
                                  item_quantity: cartModel
                                      .data!.cartItems![index].itemQuantity
                                      .toString(),
                                  onPressedAdd: () {
                                    CartCubit.get(context).updateCart(
                                        cart_item_id: cartModel
                                            .data!.cartItems![index].itemId!,
                                        quantity: cartModel
                                                .data!
                                                .cartItems![index]
                                                .itemQuantity! +
                                            1);
                                  },
                                  onPressedRemove: () {
                                    CartCubit.get(context).updateCart(
                                        cart_item_id: cartModel
                                            .data!.cartItems![index].itemId!,
                                        quantity: cartModel
                                                .data!
                                                .cartItems![index]
                                                .itemQuantity! -
                                            1);
                                  },
                                  onPressedDelete: () {
                                    CartCubit.get(context).deleteCart(
                                        cart_item_id: cartModel
                                            .data!.cartItems![index].itemId!);
                                  },
                                );
                              },
                              itemCount: cartModel.data!.cartItems!.length),
                  bottomNavigationBar: CartCubit.get(context)
                          .cartModel!
                          .data!
                          .cartItems!
                          .isEmpty
                      ? null
                      : Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Total Price : ${CartCubit.get(context).cartModel!.data!.total ?? '0'} L.E',
                                style: getBodyStyle(context,
                                    color: AppColors.whiteColor),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  CartCubit.get(context).check_out(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.primaryColor),
                                child: const Text('CheckOut'),
                              )
                            ],
                          ),
                        ),
                )
              : ShmmerListItma(
                  itemCount: 4,
                );
        },
      ),
    );
  }
}
