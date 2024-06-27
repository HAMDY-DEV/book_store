import 'package:book_store/core/function/routing.dart';
import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/core/services/token.dart';
import 'package:book_store/features/cart/model/cart_model.dart';
import 'package:book_store/features/cart/presentation/manager/cart_cubit_state.dart';
import 'package:book_store/features/check_out/model/check_order_model.dart';
import 'package:book_store/features/check_out/presentation/view/check_out_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartCubitInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  CartModel? cartModel;

  void getCart() {
    emit(CartCubitLoading());
    DioHelper.getData(
      url: 'cart',
      token: Token.getToken(),
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartCubitSuccess());
    }).catchError((error) {
      emit(CartCubitError(error.toString()));
    });
  }

  void deleteCart({required int cart_item_id}) {
    emit(CartCubitLoading());
    DioHelper.postData(
        url: 'remove-from-cart',
        data: {'cart_item_id': cart_item_id}).then((value) {
      getCart();
      emit(CartCubitSuccess());
    }).catchError((error) {
      emit(CartCubitError(error.toString()));
    });
  }

  void updateCart({required int cart_item_id, required int quantity}) {
    emit(CartCubitLoading());
    DioHelper.postData(
            url: 'update-cart',
            data: {'cart_item_id': cart_item_id, 'quantity': quantity})
        .then((value) {
      getCart();
      emit(CartCubitSuccess());
    }).catchError((error) {
      emit(CartCubitError(error.toString()));
    });
  }

  void check_out(context) {
    emit(CheckoutLoading());
    DioHelper.getData(url: 'checkout').then((value) {
      navigatorTo(
          context,
          CheckOutView(
            checkOrderModel: CheckOrderModel.fromJson(value.data),
          ));
      emit(CheckoutSuccess());
    }).catchError((error) {
      emit(CheckoutError(error.toString()));
    });
  }
}
