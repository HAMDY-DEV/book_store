import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListCart extends StatelessWidget {
  ListCart({
    super.key,
    required this.itemProductName,
    required this.itemProductImage,
    required this.itemProductDiscount,
    required this.item_product_price,
    required this.item_product_price_after_discount,
    required this.item_quantity,
    required this.onPressedAdd,
    required this.onPressedRemove,
    required this.onPressedDelete,
  });
  String itemProductName;
  String itemProductImage;
  String itemProductDiscount;
  String item_product_price;
  String item_product_price_after_discount;
  String item_quantity;

  final Function() onPressedAdd;
  final Function() onPressedRemove;
  final Function() onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
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
                    image: NetworkImage(itemProductImage), fit: BoxFit.fill)),
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
                      '%$itemProductDiscount',
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
                flex: 3,
              ),
              Container(
                margin: const EdgeInsets.all(2),
                width: 150,
                child: Text(
                  maxLines: 2,
                  itemProductName,
                  style: getBodyStyle(context, color: AppColors.blackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                      onPressed: onPressedAdd, icon: const Icon(Icons.add)),
                  Text(
                    item_quantity,
                    style: getBodyStyle(context),
                  ),
                  IconButton(
                      onPressed: onPressedRemove,
                      icon: const Icon(Icons.remove)),
                ],
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const Spacer(
                flex: 10,
              ),
              IconButton(
                  onPressed: onPressedDelete,
                  icon: Icon(
                    Icons.delete,
                    color: AppColors.redColor,
                  )),
              const Spacer(),
              Stack(
                children: [
                  Text(
                    item_product_price,
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
                item_product_price_after_discount,
                style: getSmallStyle(
                    fontSize: 15, context, color: AppColors.primaryColor),
              ),
              const Spacer(
                flex: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
