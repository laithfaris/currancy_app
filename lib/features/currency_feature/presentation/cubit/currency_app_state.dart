part of 'currency_app_cubit.dart';

abstract class CurrencyAppState extends Equatable {
  const CurrencyAppState();
}

class CurrencyAppInitial extends CurrencyAppState {
  @override
  List<Object> get props => [];
}
class CurrencyAppLoading extends CurrencyAppState {
  @override
  List<Object> get props => [];
}
class CurrencyAppLoaded extends CurrencyAppState {
  const CurrencyAppLoaded();

  @override
  List<Object> get props => [];
}
class CurrencyAppError extends CurrencyAppState {
  final String message;
  const CurrencyAppError({required this.message});
  @override
  List<Object> get props => [message];
}
class ResultConvertLoading extends CurrencyAppState {
  const ResultConvertLoading();

  @override
  List<Object> get props => [];
}
class ResultConvertLoaded extends CurrencyAppState {
  const ResultConvertLoaded();

  @override
  List<Object> get props => [];
}

class GetHistoricalLoading extends CurrencyAppState {
  const GetHistoricalLoading();

  @override
  List<Object> get props => [];
}
class GetHistoricalLoaded extends CurrencyAppState {
  const GetHistoricalLoaded();

  @override
  List<Object> get props => [];
}