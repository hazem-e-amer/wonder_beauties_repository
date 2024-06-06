import 'package:wonder_beauties/application/home/models/product_model.dart';
import 'package:wonder_beauties/configure_di.dart';
import 'package:wonder_beauties/core/data/new_remote/network_service.dart';
import 'package:wonder_beauties/core/data/new_remote/response_model.dart';

abstract class CategoriesRepo {
  Future<List<String>> getCategories();
  Future getProducts();
  Future getProductDetails({required String id});
}

class CategoriesRepoImpl implements CategoriesRepo {
  NetworkService networkService;
  CategoriesRepoImpl(
    this.networkService,
  );
  @override
  Future<List<String>> getCategories() async {
    ResponseModel response = await getIt<NetworkService>().sendRequest(
      'products/categories',
      bodyType: BodyType.json,
      method: HttpMethod.get,
    );
    return response.list.map((e) => e.toString()).toList();
  }

  @override
  Future getProducts() async {
    ResponseModel response = await getIt<NetworkService>().sendRequest(
      'products',
      bodyType: BodyType.json,
      method: HttpMethod.get,
    );
    return response.list.map((e) => ProductModel.fromJson(e)).toList() ?? [];
  }

  @override
  Future getProductDetails({required String id}) async {
    ResponseModel response = await getIt<NetworkService>().sendRequest(
      'products/$id',
      bodyType: BodyType.json,
      method: HttpMethod.get,
    );
    return ProductModel.fromJson(response.productModel);
  }
}
