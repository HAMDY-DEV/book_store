import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/home/model/bast_sellrey/product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItmListBestSellrey extends StatelessWidget {
  ItmListBestSellrey({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 180,
            width: 115,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 7,
                    offset: const Offset(0, 6), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                    image: NetworkImage(product.image!), fit: BoxFit.fill)),
            //Discount %
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    alignment: Alignment.center,
                    height: 13,
                    width: 23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.primaryColor),
                    child: Text(
                      '%${product.discount.toString()}',
                      style: getSmallStyle(context,
                          color: AppColors.whiteColor, fontSize: 8),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2),
            width: 115,
            child: Text(
              product.name.toString(),
              style: getBodyStyle(context, color: AppColors.blackColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 100,
            child: Text(
              product.category.toString(),
              overflow: TextOverflow.ellipsis,
              style: getSmallStyle(fontSize: 15, context),
            ),
          ),
          Stack(
            children: [
              Text(
                '${product.price.toString()} L.E',
                style: getSmallStyle(context, color: AppColors.greyColor),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Divider(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          Text(
            '${product.priceAfterDiscount.toString()} L.E',
            style: getSmallStyle(
                fontSize: 12, context, color: AppColors.primaryColor),
          )
        ],
      ),
    );
  }
}
