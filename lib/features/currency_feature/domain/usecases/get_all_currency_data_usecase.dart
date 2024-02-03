import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/currency_repository.dart';

class GetAllCurrencyDataUseCase extends UseCase<void,NoParams> {
  final CurrencyRepository currencyRepository;
  GetAllCurrencyDataUseCase({required this.currencyRepository});
  @override
  Future<Either<Failures,List>> call(NoParams params) async{
    return await currencyRepository.getAllCurrencyData();
  }
}