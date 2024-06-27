import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.index, required this.categoryModel});
  var categoryModel;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.greyColor),
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
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 7,
                    offset: const Offset(0, 6), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                    image: NetworkImage(categoryModel.products![index].image!),
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
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.primaryColor),
                    child: Text(
                      '%${categoryModel.products![index].discount}',
                      style: getSmallStyle(context,
                          color: AppColors.whiteColor, fontSize: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 4,
              ),
              Container(
                margin: const EdgeInsets.all(2),
                width: 150,
                child: Text(
                  maxLines: 2,
                  categoryModel.products![index].name!,
                  style: getBodyStyle(context, color: AppColors.blackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                child: Text(
                  'Stock: ${categoryModel.products![index].stock}',
                  overflow: TextOverflow.ellipsis,
                  style: getSmallStyle(fontSize: 17, context),
                ),
              ),
              const Spacer(),
              Stack(
                children: [
                  Text(
                    "${categoryModel.products![index].price.toString()} L.E",
                    style: getSmallStyle(context,
                        fontSize: 15, color: AppColors.greyColor),
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
              const Spacer(),
              Text(
                "${categoryModel.products![index].priceAfterDiscount.toString()} L.E",
                style: getSmallStyle(
                    fontSize: 15, context, color: AppColors.primaryColor),
              ),
              const Spacer(
                flex: 8,
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
