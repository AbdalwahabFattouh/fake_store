import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// استبدل هذه الاستيرادات بالنماذج الخاصة بك
import '../../features/cart/data/model/cart_model.dart';
import '../../features/cart/data/model/cart_item_model.dart';

class IsarDBHelper {
  IsarDBHelper._privateConstructor();
  static final IsarDBHelper instance = IsarDBHelper._privateConstructor();

  Isar? _isar;
  bool _isInitializing = false;
  bool _isInitialized = false;

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

      _isar = await Isar.open([CartModelSchema], directory: dir.path);

      _isInitialized = true;
    } catch (e) {
      print('Isar initialization error: $e');
    } finally {
      _isInitializing = false;
    }
  }

  Isar get isar {
    if (_isar == null) {
      throw Exception('Isar has not been initialized. Call init() first.');
    }
    return _isar!;
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
    _isInitialized = false;
  }
}
