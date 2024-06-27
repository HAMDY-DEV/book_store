import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/home/model/categories_model/categories_model.dart';
import 'package:book_store/features/home/presentation/manager/home_cubit.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:book_store/features/home/presentation/widget/shimmer_categorie.dart';
import 'package:book_store/features/show_category/presentation/view/show_category_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Categories',
              style: getTitleStyle(context),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_rounded)
          ],
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            CategoriesModel? categoriesModel =
                HomeCubit.get(context).categoriesModel;
            return categoriesModel == null
                ? const ShimmerCategorie()
                : SizedBox(
                    height: 110,
                    child: ListView.builder(
                      itemCount: categoriesModel.data!.categories!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              navigatorTo(
                                  context,
                                  ShowCategory(
                                    id: categoriesModel
                                        .data!.categories![index].id
                                        .toString(),
                                    name: categoriesModel
                                        .data!.categories![index].name!,
                                  ));
                            },
                            child: Container(
                              height: 110,
                              width: 105,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/book_b.jpg'))),
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 110,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          AppColors.blackColor.withOpacity(0.4),
                                    ),
                                    child: Text(
                                      categoriesModel
                                              .data!.categories![index].name ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: getSmallStyle(context,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        )
      ],
    );
  }
}
