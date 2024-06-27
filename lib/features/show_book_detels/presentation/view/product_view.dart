import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/core/widget/shmmer_list_itma.dart';
import 'package:book_store/core/widget/show_loading_and_error.dart';
import 'package:book_store/features/show_book_detels/model/products_model.dart';
import 'package:book_store/features/show_book_detels/presentation/manager/product_cubit.dart';
import 'package:book_store/features/show_book_detels/presentation/manager/product_state.dart';
import 'package:book_store/features/show_book_detels/presentation/widget/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ProductView extends StatelessWidget {
  ProductView({super.key});
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Book Store',
          style: getTitleStyle(context, fontSize: 20),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProductCubit()
          ..getProducts()
          ..getFavorite(),
        child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 5),
            child: BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is AddFavoriteSuccess) {
                  showSnackBar(
                      context: context, textError: 'Added To Favorite');
                } else if (state is RemoveFavoriteSuccess) {
                  showSnackBar(context: context, textError: 'Remove Favorite');
                } else if (state is AddToCartSuccess) {
                  showSnackBar(context: context, textError: 'Added To Cart');
                } else {}
              },
              builder: (context, state) {
                ProductsModel? productsModel =
                    ProductCubit.get(context).productsModel;
                var products = productsModel?.data!.products;

                return productsModel != null
                    ? Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) {
                                search = value;
                              },
                              onFieldSubmitted: (value) {
                                ProductCubit.get(context)
                                    .searchBook(name: value);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        search != ''
                                            ? ProductCubit.get(context)
                                                .searchBook(name: search)
                                            : ProductCubit.get(context)
                                                .getProducts();
                                      },
                                      icon: const Icon(Icons.search))),
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return BookListItem(
                                    index: index,
                                    products: products,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount:
                                    productsModel.data!.products!.length),
                          ),
                        ],
                      )
                    : ShmmerListItma(
                  itemCount: 4,
                );
              },
            )),
      ),
    );
  }
}
