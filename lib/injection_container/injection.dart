import 'package:currancy_app/features/currency_feature/data/data_source/remote_data_source/currency_remote_data_source.dart';
import 'package:currancy_app/features/currency_feature/data/repository_implementation/currency_repository_implementation.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/currency_feature/domain/repository/currency_repository.dart';
import '../features/currency_feature/domain/usecases/get_all_currency_data_usecase.dart';
import '../features/currency_feature/domain/usecases/get_historical_for_currency_usecase.dart';
import '../features/currency_feature/presentation/cubit/currency_app_cubit.dart';
  GetIt  sl = GetIt.instance;

Future<void> init() async {
  //Injections

  //! Core
  //! External
  sl.registerFactory(() => Dio());

  sl.registerFactory(() => CurrencyAppCubit(sl(),sl()));

   sl.registerFactory<GetAllCurrencyDataUseCase>(
          () => GetAllCurrencyDataUseCase(currencyRepository:sl<CurrencyRepository>()));
  sl.registerFactory<GetHistoricalCurrencyDataUseCase>(() =>
      GetHistoricalCurrencyDataUseCase(currencyRepository: sl<CurrencyRepository>()));

  sl.registerLazySingleton<CurrencyRepository>(
        () => CurrencyRepositoryImplementation(
          currencyRemoteDataSource: sl<CurrencyRemoteDataSource>()
  ));
   sl.registerLazySingleton<CurrencyRemoteDataSource>(() => CurrencyRemoteDataSourceImplementation());







}
