import 'package:fakestoretask/core/constants/api_endpoints.dart';
import 'package:fakestoretask/core/errors/exceptions.dart';
import 'package:fakestoretask/core/network/api_cclient.dart';
import '../model/product_model.dart';

/// واجهة المصدر البعيد للمنتجات
abstract class RemoteProductDataSource {
  Future<List<ProductModel>> getProducts();
}

/// تنفيذ المصدر البعيد
class RemoteProductDataSourceImpl implements RemoteProductDataSource {
  final ApiClient apiClient;

  RemoteProductDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      print('🔄 Fetching products from API...');
      final response = await apiClient.get(ApiEndpoints.products);

      // تحقق أن الاستجابة قائمة
      if (response is! List) {
        throw ServerException(
          message: 'Invalid response format: expected List but got ${response.runtimeType}',
        );
      }

      // تحويل القائمة إلى نماذج
      final products = response
          .whereType<Map>() // تأكد أن العناصر عبارة عن خرائط
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
