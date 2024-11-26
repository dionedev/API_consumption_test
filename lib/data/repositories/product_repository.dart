import 'package:consumoapi/data/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
}

class ProductRepository implements IProductRepository {
  @override
  Future<List<ProductModel>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
