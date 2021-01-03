import 'package:flutter/material.dart';
import 'package:macro_bank/models/currency.dart';
import 'package:macro_bank/models/currency_data.dart';
import 'package:provider/provider.dart';

import 'currency_tile.dart';

class AddCurrencyList extends StatefulWidget {
  @override
  _AddCurrencyListState createState() => _AddCurrencyListState();
}

class _AddCurrencyListState extends State<AddCurrencyList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        List<Currency> currencies = currencyData.currencies;
        return ListView.builder(
          itemBuilder: (context, index) {
            final currency = currencies[index];
            return CurrencyTile(
              currency: currency,
            );
          },
          itemCount: currencies.length,
        );
      },
    );
  }
}
