import 'package:bitcoin_app/data/datasources/remote_data_source.dart';
import 'package:bitcoin_app/data/repositories/price_data_repository_impl.dart';
import 'package:bitcoin_app/domain/repositories/price_data_repository.dart';
import 'package:bitcoin_app/domain/usecase/get_price_data.dart';
import 'package:bitcoin_app/presentation/app_state/bitcoin_state/price_data_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //provider
  locator.registerFactory(() => PriceDataNotifier(locator()));

  //usecase
  locator.registerLazySingleton(() => GetPriceData(locator()));

  //repository
  locator.registerLazySingleton<PriceDataRepository>(
      () => PriceDataRepositoryImpl(remoteDataSource: locator()));

  //data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
