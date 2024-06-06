// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'categories_bloc.dart';

class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {}

class GetProductsEvent extends CategoriesEvent {
  String categoryName;
  GetProductsEvent({
    required this.categoryName,
  });
}

class GetProductDetailsById extends CategoriesEvent {
  String id;
  GetProductDetailsById({required this.id});
}
