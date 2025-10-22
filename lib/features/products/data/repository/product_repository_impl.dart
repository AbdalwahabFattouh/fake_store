import 'package:fakestoretask/core/errors/exceptions.dart';
import 'package:fakestoretask/features/products/data/datasources/reomte_product_datasource.dart';
import 'package:fakestoretask/features/products/data/model/product_model.dart';
import 'package:fakestoretask/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteProductDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      print(products);
      return products;
    } on AppException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
