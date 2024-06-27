import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/description/presenntation/view/description_view.dart';
import 'package:book_store/features/home/model/bast_sellrey/books_data.dart';
import 'package:book_store/features/home/presentation/manager/home_cubit.dart';
import 'package:book_store/features/home/presentation/manager/home_state.dart';
import 'package:book_store/features/home/presentation/widget/home_shimmer.dart';
import 'package:book_store/features/home/presentation/widget/itmList_best_sellrey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellreyView extends StatelessWidget {
  const BestSellreyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Best Sellrey',
              style: getTitleStyle(context),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_rounded)
          ],
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            BooksData? bastSellrey = HomeCubit.get(context).bastSellrey;
            return bastSellrey == null
                ? const HomeShimmer()
                : SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: bastSellrey.data!.products!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigatorTo(
                                context,
                                DescriptionView(
                                  id: bastSellrey.data!.products![index].id!,
                                ));
                          },
                          child: ItmListBestSellrey(
                            product: bastSellrey.data!.products![index],
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ],
    );
  }
}
