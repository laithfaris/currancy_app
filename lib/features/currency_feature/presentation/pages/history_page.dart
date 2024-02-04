import 'package:currancy_app/features/currency_feature/presentation/cubit/currency_app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<CurrencyAppCubit>().getAllHistoricalCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyAppCubit, CurrencyAppState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Center(
                        child: Text(context
                            .read<CurrencyAppCubit>()
                            .listHistory[index]["date"]
                            .toString()
                            ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "code: ${context.read<CurrencyAppCubit>().listHistory[index]["data"]["CAD"]["code"]}"),
                            Text(
                                "value: ${context.read<CurrencyAppCubit>().listHistory[index]["data"]["CAD"]["value"]}")
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "code: ${context.read<CurrencyAppCubit>().listHistory[index]["data"]["EUR"]["code"]}"),
                            Text(
                                "value: ${context.read<CurrencyAppCubit>().listHistory[index]["data"]["EUR"]["value"]}")
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "code: ${context.read<CurrencyAppCubit>().listHistory[index]["data"]["USD"]["code"]}"),
                            Text(
                                "value: ${context.read<CurrencyAppCubit>().listHistory[index]["data"]["USD"]["value"]}")
                          ],
                        ),
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.black,
                      )
                    ],
                  );
                },
                shrinkWrap: true,
                itemCount: context.read<CurrencyAppCubit>().listHistory.length,
              ),
            ));
      },
    );
  }
}
