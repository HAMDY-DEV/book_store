import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/util/colors.dart';
import 'package:book_store/core/util/text_style.dart';
import 'package:book_store/features/order_histoey/model/order_histoey/order_histoey.dart';
import 'package:book_store/features/order_histoey/presentation/manager/order_histoey_cubit.dart';
import 'package:book_store/features/order_histoey/presentation/manager/order_histoey_state.dart';
import 'package:book_store/features/order_histoey/presentation/view/singel_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoeyView extends StatelessWidget {
  const OrderHistoeyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderHistoeyCubit()..getOrderHistory(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Order History',
            style: getTitleStyle(context, color: AppColors.primaryColor),
          ),
        ),
        body: BlocBuilder<OrderHistoeyCubit, OrderHistoeyState>(
          builder: (context, state) {
            OrderHistoeyModel? orderHistoeyModel =
                OrderHistoeyCubit.get(context).orderHistoeyModel;

            return orderHistoeyModel == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: orderHistoeyModel.data!.orders!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          navigatorTo(
                              context,
                              SingelOrderView(
                                id: orderHistoeyModel.data!.orders![index].id!,
                              ));
                        },
                        title: Text(
                          orderHistoeyModel.data!.orders![index].orderCode
                              .toString(),
                          style: getBodyStyle(context, fontSize: 15),
                        ),
                        subtitle: Text(
                          orderHistoeyModel.data!.orders![index].orderDate
                              .toString(),
                          style: getBodyStyle(context, fontSize: 15),
                        ),
                        trailing: Text(
                          orderHistoeyModel.data!.orders![index].total
                              .toString(),
                          style: getBodyStyle(context, fontSize: 12),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        indent: 20,
                        endIndent: 20,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
