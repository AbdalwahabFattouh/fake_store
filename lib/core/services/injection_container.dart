import 'package:fakestoretask/core/network/api_cclient.dart';
import 'package:fakestoretask/core/services/isar_db_helper.dart';
import 'package:fakestoretask/core/services/local_storage_service.dart';
import 'package:fakestoretask/features/auth/data/datasources/local_auth_datasource.dart';
import 'package:fakestoretask/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:fakestoretask/features/auth/data/repository/auth_repository_impl.dart';
import 'package:fakestoretask/features/auth/domain/repositories/auth_repository.dart';
import 'package:fakestoretask/features/auth/domain/usecases/login_usercase.dart';
import 'package:fakestoretask/features/auth/domain/usecases/register_usecase.dart';
import 'package:fakestoretask/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fakestoretask/features/cart/data/datasource/local_cart_data_source.dart';
import 'package:fakestoretask/features/cart/data/repository/cart_repository_impl.dart';
import 'package:fakestoretask/features/cart/domain/repository/cart_repository.dart';
import 'package:fakestoretask/features/cart/domain/usecase/add_item_to_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/checkout_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/clear_cart_items.dart';
import 'package:fakestoretask/features/cart/domain/usecase/delete_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/get_all_carts.dart';
import 'package:fakestoretask/features/cart/domain/usecase/get_cart_by_id.dart';
import 'package:fakestoretask/features/cart/domain/usecase/insert_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/remove_item_from_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/update_cart.dart';
import 'package:fakestoretask/features/cart/domain/usecase/update_item_quantity.dart';
import 'package:fakestoretask/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fakestoretask/features/products/data/datasources/reomte_product_datasource.dart';
import 'package:fakestoretask/features/products/data/repository/product_repository_impl.dart';
import 'package:fakestoretask/features/products/domain/repository/product_repository.dart';
import 'package:fakestoretask/features/products/presentation/bloc/product_bloc.dart';
import 'package:fakestoretask/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:fakestoretask/features/profile/domain/usecase/logout_usecase.dart';
import 'package:fakestoretask/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/profile/data/repository/profile_repositroy_impl.dart';
import '../../features/profile/domain/repository/profile_reposiory.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core Services
  final localStorage = LocalStorageService();
  await localStorage.init();
  sl.registerLazySingleton(() => localStorage);

  sl.registerLazySingleton(() => ApiClient());

  sl.registerLazySingleton<IsarDBHelper>(() => IsarDBHelper.instance);

  // Data Sources
  sl.registerLazySingleton<RemoteAuthDatasource>(
        () => RemoteAuthDatasourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<LocalAuthDatasource>(
        () => LocalAuthDatasourceImpl(localStorageService: sl()),
  );

  sl.registerLazySingleton<RemoteProductDataSource>(
        () => RemoteProductDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<LocalCartDataSource>(
        () => LocatCartDataSource(isarDBHelper: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerLazySingleton(() => GetAllCarts(sl()));
  sl.registerLazySingleton(() => InsertCart(sl()));
  sl.registerLazySingleton(() => DeleteCart(sl()));
  sl.registerLazySingleton(() => UpdateCart(sl()));
  sl.registerLazySingleton(() => GetCartById(sl()));
  sl.registerLazySingleton(() => AddItemToCart(sl()));
  sl.registerLazySingleton(() => RemoveItemFromCart(sl()));
  sl.registerLazySingleton(() => UpdateItemQuantity(sl()));
  sl.registerLazySingleton(() => ClearCartItems(sl()));
  sl.registerLazySingleton(() => CheckoutCart(sl()));

  // ✅ Add Profile Use Cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteAuthDatasource: sl(),
      localAuthDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(localCartDataSource: sl()),
  );

  // ✅ Add Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(localStorageService: sl()),
  );

  // Blocs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl(), registerUseCase: sl()));
  sl.registerFactory(() => ProductBloc(productRepository: sl()));

  sl.registerFactory(
        () => CartBloc(
      getAllCarts: sl(),
      insertCart: sl(),
      deleteCart: sl(),
      updateCart: sl(),
      getCartById: sl(),
      addItemToCart: sl(),
      removeItemFromCart: sl(),
      updateItemQuantity: sl(),
      clearCartItems: sl(),
      checkoutCart: sl(),
    ),
  );

  sl.registerFactory(
        () => ProfileBloc(
      getProfileUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}
