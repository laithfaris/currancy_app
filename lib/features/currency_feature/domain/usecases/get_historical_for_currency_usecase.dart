import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/currency_repository.dart';

class GetHistoricalCurrencyDataUseCase
    extends UseCase<void, GetHistoricalCurrencyDataParams> {
  late final CurrencyRepository currencyRepository;

  GetHistoricalCurrencyDataUseCase({required this.currencyRepository});

  @override
  Future<Either<Failures,  Map<String, dynamic>>> call(
      GetHistoricalCurrencyDataParams params) async {
    return await currencyRepository.getHistoricalCurrencyData(params.date!);
  }
}

// ignore: must_be_immutable
class GetHistoricalCurrencyDataParams extends Equatable {
  String? date;

  GetHistoricalCurrencyDataParams(this.date);

  @override
  List<Object?> get props => [date];
}
