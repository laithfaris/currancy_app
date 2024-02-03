import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repository/currency_repository.dart';
import '../data_source/remote_data_source/currency_remote_data_source.dart';

class CurrencyRepositoryImplementation extends CurrencyRepository
{CurrencyRepositoryImplementation({required this.currencyRemoteDataSource});
    CurrencyRemoteDataSource currencyRemoteDataSource;
  @override
   Future<Either<Failures, List>> getAllCurrencyData()  async{
    try {
    final remote = await currencyRemoteDataSource.getAllCurrencyData();
    return Right(remote);
    } on ServerException {
    return const Left(ServerFailure( failure: 'errorServer'));
    }


  }


  @override
  Future<Either<Failures,  Map<String, dynamic>>>  getHistoricalCurrencyData(String date) async{
    try {
      final remote = await currencyRemoteDataSource.getHistoricalCurrencyData(date);
      return Right(remote);
    } on ServerException {
      return const Left(ServerFailure( failure: 'errorServer'));
    }
  }

}