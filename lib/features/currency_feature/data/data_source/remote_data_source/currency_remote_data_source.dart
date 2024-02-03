import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/network/network_helper.dart';

abstract class CurrencyRemoteDataSource {
  Future<List> getAllCurrencyData();

  Future <Map<String, dynamic>> getHistoricalCurrencyData(String date);
}

class CurrencyRemoteDataSourceImplementation extends CurrencyRemoteDataSource {
  @override
  getAllCurrencyData() async {
    try {
      final result = await DioHelper.getData(
          url:
              "https://api.currencyapi.com/v2/latest?apikey=fca_live_T5mzsd2SAJCb2rPQCB3utxwmsbSGwj6jfT1am8H0");
      if (result.statusCode == 200) {
        Map<String, dynamic> currencyData = result.data['data'];

        List currencyList = [];
        String flag = "";
        for (var currencyData1 in currencyData.entries) {
          flag = await getCountriesFlagData(
              currencyData1.key.toLowerCase().substring(0, 2));
          Map<String, dynamic> map = {
            "code": currencyData1.key,
            "value": currencyData1.value,
            "flag": flag,
          };
          currencyList.add(map);
        }
        GetStorage().write("currencies", currencyList);
        if (kDebugMode) {
          print(currencyList);
        }
        return currencyList;
      } else {
        // Handle other status codes
        if (kDebugMode) {
          print("Failed to fetch data. Status code: ${result.statusCode}");
        }
      }
    } catch (error) {
      // Handle errors
      print("Error: $error");
    }

    return [];
  }

  getCountriesFlagData(String countryCode) async {
    try {
      final image = await DioHelper.getImage(
          url: "https://flagcdn.com/16x12/$countryCode.png");
      Directory documentsDirectory =
          (await getExternalStorageDirectories())![0];
      String dir = documentsDirectory.path;
      File file = File('$dir/$countryCode.png');
      await file.writeAsBytes(image.data);
      if (kDebugMode) {
        print(file.path);
      }
      return file.path;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  getHistoricalCurrencyData(String date) async {
    Map<String, dynamic> listOfHistory = {};
    try {
      final result = await DioHelper.getData(
          url:
              "https://api.currencyapi.com/v3/historical?apikey=fca_live_T5mzsd2SAJCb2rPQCB3utxwmsbSGwj6jfT1am8H0&currencies=EUR%2CUSD%2CCAD&date=$date");
      if (result.statusCode == 200) {
        Map<String, dynamic> currencyHistory = result.data['data'];

        listOfHistory =
          {
            "date": date,
            "data": currencyHistory,
          }
        ;

        return listOfHistory;
      } else {
        // Handle other status codes
        if (kDebugMode) {
          print("Failed to fetch data. Status code: ${result.statusCode}");
        }
      }
    } catch (error) {
      // Handle errors
      print("Error: $error");
    }
    return listOfHistory;
  }
}
