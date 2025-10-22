import 'package:fakestoretask/core/constants/api_endpoints.dart';
import 'package:fakestoretask/core/errors/exceptions.dart';
import 'package:fakestoretask/core/network/api_cclient.dart';
import '../model/product_model.dart';

abstract class RemoteProductDataSource {
  Future<List<ProductModel>> getProducts();
}

class RemoteProductDataSourceImpl implements RemoteProductDataSource {
  final ApiClient apiClient;

  RemoteProductDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      print('🔄 Fetching products from API...');
      final response = await apiClient.get(ApiEndpoints.products);

      if (response is! List) {
        throw ServerException(
          message: 'Invalid response format: expected List but got ${response.runtimeType}',
        );
      }

      final products = response
          .whereType<Map>()
          .map((item) => ProductModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      print('✅ Successfully fetched ${products.length} products');
      return products;
    } catch (e) {
      print('❌ Error while fetching products: $e');
      throw ServerException(message: 'Failed to fetch products: $e');
    }
  }
}
