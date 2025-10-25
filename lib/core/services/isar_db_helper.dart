import 'dart:async';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/cart/data/model/cart_model.dart';
import '../../features/cart/data/model/cart_item_model.dart';

class IsarDBHelper {
  IsarDBHelper._privateConstructor();
  static final IsarDBHelper instance = IsarDBHelper._privateConstructor();

  Isar? _isar;
  bool _isInitializing = false;
  bool _isInitialized = false;
  final Completer<void> _initCompleter = Completer<void>();

  Future<void> init() async {
    if (_isInitialized || _isInitializing) return;

    _isInitializing = true;
    try {
      Directory dir;
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        dir = await getApplicationSupportDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      // أضف فقط الـ Collections الرئيسية هنا
      _isar = await Isar.open(
        [
          CartModelSchema, // فقط الـ Collection الرئيسي
        ],
        directory: dir.path,
        inspector: true,
      );

      _isInitialized = true;
      print("✅ Isar initialized with collections: [CartModel]");
    } catch (e, stackTrace) {
      print('❌ Isar initialization error: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> _testConnection() async {
    try {
      // اختبار بسيط للاتصال بقاعدة البيانات
      final count = await _isar!.cartModels.count();
      print("🔍 Test connection successful. Cart count: $count");
    } catch (e) {
      print("❌ Database test failed: $e");
      throw Exception('Database test failed: $e');
    }
  }

  Isar get isar {
    if (_isar == null || !_isInitialized) {
      throw Exception('Isar has not been initialized. Call init() first.');
    }
    return _isar!;
  }

  // دالة للتحقق من حالة التهيئة
  bool get isInitialized => _isInitialized;

  // دالة للانتظار حتى اكتمال التهيئة
  Future<void> ensureInitialized() async {
    if (!_isInitialized && !_isInitializing) {
      await init();
    }
    if (_isInitializing) {
      await _initCompleter.future;
    }
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
    _isInitialized = false;
    _isInitializing = false;
  }
}