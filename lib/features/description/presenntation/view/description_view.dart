import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/custom_button.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/description/presenntation/manager/description_cubit.dart';
import 'package:book_store/features/description/presenntation/manager/description_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:book_store/features/description/presenntation/model/description_model.dart';

// ignore: must_be_immutable
class DescriptionView extends StatelessWidget {
  DescriptionView({super.key, required this.id});
  int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DescriptionCubit()
          ..products(id: id)
          ..getFavorite(),
        child: BlocConsumer<DescriptionCubit, DescriptionState>(
          listener: (context, state) {
            if (state is DescriptionAddToFavoriteSuccess) {
              showSnackBar(context: context, textError: 'Added To Favorite');
            } else if (state is RemoveFavoriteSuccess) {
              showSnackBar(context: context, textError: 'Remove Favorite');
            } else {}
          },
          builder: (context, state) {
            var cubit = DescriptionCubit.get(context);
            DescriptionModel? product =
                DescriptionCubit.get(context).descriptionModel;
            return product == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            }, product.data!.image!),
                            const Gap(20),
                            Text(
                              product.data!.name!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              style: getTitleStyle(context,
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    product.data!.category!,
                                    style: getBodyStyle(context,
                                        color: AppColors.greyColor),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Divider(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          Text(
                                            product.data!.price!,
                                            style: getSmallStyle(context,
                                                color: AppColors.greyColor),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        product.data!.priceAfterDiscount!
                                            .toString(),
                                        style: getSmallStyle(context,
                                            color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Gap(30),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Description',
                                style: getBodyStyle(context,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  style: getBodyStyle(context,
                                      color: AppColors.greyColor),
                                  product.data!.description!),
                            ),
                            const Gap(60),
                          ],
                        ),
                        Positioned(
                            top: 50,
                            left: 20,
                            right: 20,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.blackColor,
                                    )),
                                const Spacer(),
                                InkWell(
                                    onTap: () {
                                      cubit.favoriteId
                                              .contains(product.data!.id!)
                                          ? DescriptionCubit.get(context)
                                              .removeInFavorite(
                                                  id: product.data!.id!)
                                          : DescriptionCubit.get(context)
                                              .addToFavorite(
                                                  id: product.data!.id!);
                                    },
                                    child: Visibility(
                                      visible: DescriptionCubit.get(context)
                                          .favoriteId
                                          .contains(product.data!.id!),
                                      replacement: Icon(
                                        Icons.favorite_outline,
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        color: AppColors.primaryColor,
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: CustomButton(
        text: 'Add To Cart',
        onTap: () {
          DescriptionCubit().addToCart(product_id: id, context: context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
