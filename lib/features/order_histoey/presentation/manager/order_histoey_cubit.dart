import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/order_histoey/model/order_histoey/order_histoey.dart';
import 'package:book_store/features/order_histoey/model/single_order_histoey/single_order_histoey.dart';
import 'package:book_store/features/order_histoey/presentation/manager/order_histoey_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoeyCubit extends Cubit<OrderHistoeyState> {
  OrderHistoeyCubit() : super(OrderHistoeyInitial());

  static OrderHistoeyCubit get(context) => BlocProvider.of(context);
  OrderHistoeyModel? orderHistoeyModel;
  SingleOrderHistoeyModel? singleOrderHistoeyModel;

  void getOrderHistory() {
    emit(OrderHistoeyLoading());
    DioHelper.getData(url: 'order-history', token: Token.getToken())
        .then((value) {
      orderHistoeyModel = OrderHistoeyModel.fromJson(value.data);
      emit(OrderHistoeySuccess());
    }).catchError((onError) {
      emit(OrderHistoeyError());
    });
  }

  void getSingelOrder(int id) {
    emit(SingelOrderLoading());
    DioHelper.getData(url: 'order-history/$id', token: Token.getToken())
        .then((value) {
      singleOrderHistoeyModel = SingleOrderHistoeyModel.fromJson(value.data);
      emit(SingelOrderSuccess());
    }).catchError((onError) {
      emit(SingelOrderError());
    });
  }
}
