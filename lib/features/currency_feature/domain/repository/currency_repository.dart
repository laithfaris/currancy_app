import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class  CurrencyRepository{
  Future<Either<Failures,List >>  getAllCurrencyData();
  Future<Either<Failures,  Map<String, dynamic>>> getHistoricalCurrencyData(String date);

}