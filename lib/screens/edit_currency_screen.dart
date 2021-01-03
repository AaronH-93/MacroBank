import 'package:flutter/material.dart';
import 'package:macro_bank/models/currency_data.dart';
import 'package:macro_bank/widgets/currency_lists.dart';
import 'package:provider/provider.dart';

class EditCurrencyScreen extends StatelessWidget {
  static final String id = 'add_currency_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
        builder: (context, currencyData, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: AddCurrencyList(),
                ),
              ],
            ),
          );
        }
    );
  }
}
