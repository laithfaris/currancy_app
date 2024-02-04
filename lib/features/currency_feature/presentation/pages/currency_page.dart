import 'dart:io';

import 'package:currancy_app/features/currency_feature/presentation/cubit/currency_app_cubit.dart';
import 'package:currancy_app/features/currency_feature/presentation/pages/history_page.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_dropdown_label.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  @override
  void initState() {
    super.initState();
    context.read<CurrencyAppCubit>().getAllCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return
          Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
            child: const Icon(Icons.history),
          ),
          appBar: AppBar(actions: [IconButton(icon: Icon(Icons.refresh),onPressed: (){
            context.read<CurrencyAppCubit>().getAllCurrencyData();

          },)]),
          body: BlocBuilder<CurrencyAppCubit, CurrencyAppState>(
    builder: (context, state) {
    if(state is CurrencyAppLoading){
    return Center(
    child: CircularProgressIndicator(),
    );
    }
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              CustomDropDownLabel(
                  dropdownChild: DropdownButton<String>(
                    value: context.read<CurrencyAppCubit>().valueFrom,
                    hint: const Text(
                      "Currencies",
                      style: TextStyle(color: Colors.grey),
                    ),
                    focusColor: Colors.transparent,
                    isExpanded: true,
                    icon: const Visibility(
                      visible: true,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    elevation: 16,
                    style: const TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? value) async {
                      context.read<CurrencyAppCubit>().valueFrom =
                          value.toString();
                      var selectedItem = context
                          .read<CurrencyAppCubit>()
                          .cu
                          .firstWhere(
                              (item) => item['code'].toString() == value);

                      context.read<CurrencyAppCubit>().valueFrom =
                          selectedItem['code'].toString();
                      context.read<CurrencyAppCubit>().valueOfFrom =
                          selectedItem['value'];

                      setState(() {});
                    },
                    items: context
                        .read<CurrencyAppCubit>()
                        .cu
                        .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                                  value: value['code'],
                                  child: Row(children: [
                                    Text(value['value'].toString()),
                                    Image.file(errorBuilder:
                                        (context, error, stackTrace) {
                                      return const Text("no flag found");
                                    }, fit: BoxFit.cover, File(value['flag'])),
                                  ]),
                                ))
                        .toList(),
                  ),
                  hintText: "From"),
              CustomDropDownLabel(
                  dropdownChild: DropdownButton<String>(
                    value: context.read<CurrencyAppCubit>().valueTo,
                    hint: const Text(
                      "Currencies",
                      style: TextStyle(color: Colors.grey),
                    ),
                    focusColor: Colors.transparent,
                    isExpanded: true,
                    icon: const Visibility(
                      visible: true,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    elevation: 16,
                    style: const TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? value) async {
                      context.read<CurrencyAppCubit>().valueTo =
                          value.toString();
                      var selectedItem = context
                          .read<CurrencyAppCubit>()
                          .cu
                          .firstWhere(
                              (item) => item['code'].toString() == value);

                      // Retrieve the 'code' from the selected item and assign it to valueFrom
                      context.read<CurrencyAppCubit>().valueTo =
                          selectedItem['code'].toString();
                      context.read<CurrencyAppCubit>().valueOfTo =
                          selectedItem['value'];
                      setState(() {});
                    },
                    items: context
                        .read<CurrencyAppCubit>()
                        .cu
                        .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                                  value: value['code'],
                                  child: Row(children: [
                                    Text(value['value'].toString()),
                                    Image.file(errorBuilder:
                                        (context, error, stackTrace) {
                                      return const Text("  no flag found");
                                    }, fit: BoxFit.cover, File(value['flag'])),
                                  ]),
                                ))
                        .toList(),
                  ),
                  hintText: "To"),
              TextField(
                controller: context.read<CurrencyAppCubit>().amount,
                decoration: const InputDecoration(hintText: "Amount"),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text("Convert"),
                onPressed: () {
                  context.read<CurrencyAppCubit>().convert();
                },
              ),
              context.read<CurrencyAppCubit>().total != 0
                  ? Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                          context.read<CurrencyAppCubit>().total.round().toString()))
                  : const SizedBox()
            ]),
          );

      },
    ));
  }
}
