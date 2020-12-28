import 'package:flutter/material.dart';
import 'package:macro_bank/components/rounded_button.dart';
import 'package:macro_bank/models/currency.dart';
import 'package:macro_bank/models/currency_data.dart';
import 'package:provider/provider.dart';

class CurrencyTile extends StatelessWidget {
  final Currency currency;

  CurrencyTile({this.currency});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(builder: (context, currencyData, child) {
      return Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: CurrencyContainer(
              currencyName: currency.name,
              imageLoc: currency.imageLoc,
            ),
          ),
          RoundedButton(
            onPressed: () {
              currencyData.addCurrencyToUser(currency);
            },
            color: Colors.indigoAccent,
            title: 'ADD',
          ),
          RoundedButton(
            onPressed: () {
              currencyData.deleteCurrencyFromUser(currency);
            },
            color: Colors.indigoAccent,
            title: 'REMOVE',
          )
        ],
      );
    });
  }
}

class CurrencyContainer extends StatelessWidget {
  final String currencyName;
  final String imageLoc;

  CurrencyContainer({this.currencyName, this.imageLoc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 300,
      width: 300,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TileText(text: currencyName), Image.asset(imageLoc)],
      ),
    );
  }
}

class TileText extends StatelessWidget {
  final String text;

  TileText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
