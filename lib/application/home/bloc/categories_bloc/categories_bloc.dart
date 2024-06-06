import 'package:bloc/bloc.dart';
import 'package:wonder_beauties/application/home/models/product_model.dart';
import 'package:wonder_beauties/application/home/repository/categories_repository.dart';
import 'package:wonder_beauties/configure_di.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState.initial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, categories: null));
      await getIt<CategoriesRepo>().getCategories().then((value) async {
        emit(state.copyWith(categories: value, isLoading: false));
      }).catchError((e) {
        emit(state.copyWith(
            message: e.toString(), isLoading: false, categories: null));
      });
    });

    on<GetProductsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, products: null));
      await getIt<CategoriesRepo>().getProducts().then((value) async {
        emit(state.copyWith(products: value, isLoading: false));
        if (state.products != null) {
          state.selectedList = [];

          state.selectedList!.addAll(state.products!.where(
              (element) => element.category!.contains(event.categoryName)));
        }
      }).catchError((e) {
        emit(state.copyWith(
            message: e.toString(), isLoading: false, products: null));
      });
    });

    on<GetProductDetailsById>((event, emit) async {
      emit(state.copyWith(isLoading: true, product: null));
      await getIt<CategoriesRepo>()
          .getProductDetails(id: event.id)
          .then((value) async {
        emit(state.copyWith(product: value, isLoading: false));
      }).catchError((e) {
        emit(state.copyWith(
            message: e.toString(), isLoading: false, product: null));
      });
    });
  }
}
