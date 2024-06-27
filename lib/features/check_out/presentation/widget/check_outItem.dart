import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/check_out/model/check_order_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckOutItem extends StatelessWidget {
  CheckOutItem({super.key, required this.checkOrderModel, required this.index});
  CheckOrderModel checkOrderModel;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          checkOrderModel.data!.cartItems![index].itemProductName!,
          style:
              getBodyStyle(context, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          "Quantity: ${checkOrderModel.data!.cartItems![index].itemQuantity!}",
          style: getBodyStyle(context, fontSize: 13),
        ),
        trailing: Text(
          checkOrderModel.data!.cartItems![index].itemProductPrice!,
          style:
              getBodyStyle(context, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
