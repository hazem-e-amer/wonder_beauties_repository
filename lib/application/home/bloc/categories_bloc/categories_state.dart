part of 'categories_bloc.dart';

class CategoriesState {
  final List<String>? categories;
  final List<ProductModel>? products;
  List<ProductModel>? selectedList;
  final ProductModel? product;
  final String? message;
  final bool? isLoading;

  CategoriesState({
    this.categories,
    this.products,
    this.selectedList,
    this.product,
    this.message,
    this.isLoading,
  });

  factory CategoriesState.initial() => CategoriesState();

  CategoriesState copyWith(
      {List<String>? categories,
      List<ProductModel>? products,
      List<ProductModel>? selectedList,
      ProductModel? product,
      String? message,
      bool? isLoading}) {
    return CategoriesState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedList: selectedList ?? this.selectedList,
      product: product ?? product,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}
