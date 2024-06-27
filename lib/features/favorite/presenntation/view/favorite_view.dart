import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/shmmer_list_itma.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/favorite/presenntation/manager/favorite_cubit.dart';
import 'package:book_store/features/favorite/presenntation/manager/favorite_state.dart';
import 'package:book_store/features/favorite/presenntation/model/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite',
          style: getTitleStyle(context, fontSize: 20),
        ),
      ),
      body: BlocProvider(
        create: (context) => FavoriteCubit()..showFavorite(),
        child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 5),
            child: BlocConsumer<FavoriteCubit, FavoriteState>(
                listener: (context, state) {
              if (state is DeleteFavoriteSuccess) {
                showSnackBar(context: context, textError: 'Added To Favorite');
              } else if (state is AddToCartSuccess) {
                showSnackBar(context: context, textError: 'Added To Cart');
              } else {}
            }, builder: (context, state) {
              FavoriteModel? favoriteModel =
                  FavoriteCubit.get(context).favoriteModel;
              return favoriteModel != null
                  ? favoriteModel.data!.data!.isEmpty
                      ? Center(
                          child: SvgPicture.asset(
                            'assets/svg/undraw_favourite_item_pcyo.svg',
                            width: double.infinity,
                            height: 300,
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.greyColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    height: 120,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                6), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(
                                            image: NetworkImage(favoriteModel
                                                .data!.data![index].image!),
                                            fit: BoxFit.fill)),
                                    //Discount %
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 5,
                                          left: 5,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 15,
                                            width: 22,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: AppColors.primaryColor),
                                            child: Text(
                                              '%${favoriteModel.data!.data![index].discount}',
                                              style: getSmallStyle(context,
                                                  color: AppColors.whiteColor,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(
                                        flex: 4,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(2),
                                        width: 150,
                                        child: Text(
                                          maxLines: 2,
                                          favoriteModel
                                              .data!.data![index].name!,
                                          style: getBodyStyle(context,
                                              color: AppColors.blackColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          favoriteModel
                                              .data!.data![index].category!,
                                          overflow: TextOverflow.ellipsis,
                                          style: getSmallStyle(
                                              fontSize: 17, context),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Spacer(),
                                      Text(
                                        "${favoriteModel.data!.data![index].price!} L.E",
                                        style: getSmallStyle(
                                            fontSize: 15,
                                            context,
                                            color: AppColors.primaryColor),
                                      ),
                                      const Spacer(
                                        flex: 8,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            FavoriteCubit.get(context)
                                                .deleteFavorite(
                                                    id: favoriteModel.data!
                                                        .data![index].id!);
                                          },
                                          icon: Icon(
                                              color: AppColors.primaryColor,
                                              Icons.favorite)),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            FavoriteCubit.get(context)
                                                .addToCart(
                                                    product_id: favoriteModel
                                                        .data!
                                                        .data![index]
                                                        .id!);
                                          },
                                          icon: const Icon(
                                              Icons.shopping_cart_outlined)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: favoriteModel.data!.data!.length)
                  : ShmmerListItma(
                      itemCount: 4,
                    );
            })),
      ),
    );
  }
}
