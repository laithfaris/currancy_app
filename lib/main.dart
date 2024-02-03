import 'package:currancy_app/features/currency_feature/presentation/cubit/currency_app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currancy_app/features/currency_feature/presentation/pages/currency_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'core/network/network_helper.dart';
import 'injection_container/injection.dart'as dl;

void main() async {
  await GetStorage.init();
  DioHelper.init();
 await dl.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => dl.sl<CurrencyAppCubit>()  ,
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CurrencyPage(),
    ),
);
  }
}
