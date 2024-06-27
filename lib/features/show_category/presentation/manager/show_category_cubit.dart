import 'package:book_store/core/services/dio_helper.dart';
import 'package:book_store/features/show_category/model/show_category_model/show_category_model.dart';
import 'package:book_store/features/show_category/presentation/manager/show_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowCategoryCubit extends Cubit<ShowCategoryState> {
  ShowCategoryCubit() : super(ShowCategoryInitial());

  static ShowCategoryCubit get(context) => BlocProvider.of(context);

  ShowCategoryModel? showCategoryModel;

  getCategory({required id}) {
    showCategoryModel = null;
    emit(ShowCategoryLoading());
    DioHelper.getData(url: 'categories/$id').then((value) {
      showCategoryModel = ShowCategoryModel.fromJson(value.data);
      emit(ShowCategorySuccess());
    }).catchError((onError) {
      emit(ShowCategoryError());
    });
  }
}
