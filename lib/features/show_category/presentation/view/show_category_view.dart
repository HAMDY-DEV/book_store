import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/shmmer_list_itma.dart';
import 'package:book_store/features/description/presenntation/view/description_view.dart';
import 'package:book_store/features/show_category/presentation/manager/show_category_cubit.dart';
import 'package:book_store/features/show_category/presentation/manager/show_category_state.dart';
import 'package:book_store/features/show_category/presentation/widget/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ShowCategory extends StatelessWidget {
  ShowCategory({super.key, required this.id, required this.name});
  String id;
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          name,
          style: getTitleStyle(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: BlocProvider(
          create: (context) => ShowCategoryCubit()..getCategory(id: id),
          child: BlocBuilder<ShowCategoryCubit, ShowCategoryState>(
            builder: (context, state) {
              return ShowCategoryCubit.get(context).showCategoryModel == null
                  ? ShmmerListItma(
                      itemCount: 4,
                    )
                  : ListView.separated(
                      itemCount: ShowCategoryCubit.get(context)
                          .showCategoryModel!
                          .data!
                          .products!
                          .length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigatorTo(
                                context,
                                DescriptionView(
                                  id: ShowCategoryCubit.get(context)
                                      .showCategoryModel!
                                      .data!
                                      .products![index]
                                      .id!,
                                ));
                          },
                          child: CategoryItem(
                            index: index,
                            categoryModel: ShowCategoryCubit.get(context)
                                .showCategoryModel!
                                .data,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
