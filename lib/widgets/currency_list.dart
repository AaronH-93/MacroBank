import 'package:flutter/material.dart';
import 'package:macro_bank/models/currency.dart';
import 'package:macro_bank/models/currency_data.dart';
import 'package:provider/provider.dart';

import 'currency_tile.dart';

class CurrencyList extends StatefulWidget {
  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        List<Currency> potentialCurrencies = currencyData.generatePotentialCurrencies();
        return ListView.builder(
          itemBuilder: (context, index) {
            final currency = potentialCurrencies[index];
            return CurrencyTile(
              currency: currency,
            );
          },
          itemCount: potentialCurrencies.length,
        );
      },
    );
  }
}
