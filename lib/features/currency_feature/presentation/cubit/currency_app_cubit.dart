import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/Material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_all_currency_data_usecase.dart';
import '../../domain/usecases/get_historical_for_currency_usecase.dart';

part 'currency_app_state.dart';

class CurrencyAppCubit extends Cubit<CurrencyAppState> {
  CurrencyAppCubit(
      this.getAllCurrencyDataUseCase, this.getHistoricalCurrencyDataUseCase)
      : super(CurrencyAppInitial());
  final GetAllCurrencyDataUseCase? getAllCurrencyDataUseCase;
  final GetHistoricalCurrencyDataUseCase? getHistoricalCurrencyDataUseCase;

  List listCurrency = [];
  List listHistory = [];
  List cu = [];
  String? valueFrom;
  String? valueTo;
  num? valueOfFrom;
  num? valueOfTo;
  num total = 0;

  TextEditingController amount = TextEditingController();

  convert() {
    emit(const ResultConvertLoading());
    total = (num.parse(amount.text) / valueOfFrom!) * valueOfTo!;
    emit(const ResultConvertLoaded());
  }

  getAllCurrencyData() async {
    emit(CurrencyAppLoading());
    listCurrency.clear();
    final result = await getAllCurrencyDataUseCase?.call(NoParams());
    result?.fold((l) => emit(CurrencyAppError(message: l.failure)), (r) {
      listCurrency = r;
      log(listCurrency.toString());
    log("log list list list");
    cu = GetStorage().read("currencies");
    emit(const CurrencyAppLoaded());
  }

);
}

  getHistoricalCurrenciesData(String date) async {
    emit(const GetHistoricalLoading());
    final result = await getHistoricalCurrencyDataUseCase
        ?.call(GetHistoricalCurrencyDataParams(date));
    result?.fold((l) => emit(CurrencyAppError(message: l.failure)), (r) {
      listHistory.add(r);

      emit(const GetHistoricalLoaded());
    });
  }

  getAllHistoricalCurrency() async {
    listHistory = [];
    DateTime basicFormat =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2024, 02, 02)));
    for (int i = 0; i < 7; i++) {
      final resut = basicFormat.subtract(Duration(days: i)).toString();
    await  getHistoricalCurrenciesData(resut);
    }
  }
}
