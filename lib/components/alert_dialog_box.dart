import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_bank/models/currency_data.dart';
import 'package:provider/provider.dart';

final controller = TextEditingController();

class TransferDialogBox extends StatefulWidget {
  final String currencyName;
  final double exchangeRate;
  final BuildContext context;

  TransferDialogBox({this.currencyName, this.exchangeRate, this.context});

  @override
  _TransferDialogBoxState createState() => _TransferDialogBoxState();
}

class _TransferDialogBoxState extends State<TransferDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
        builder: (context, currencyData, child) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Enter amount to transfer',
                        hintText: 'eg. 200'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                )
              ],
            ),
            actions: <Widget>[
              AlertDialogButton(
                text: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              AlertDialogButton(
                text: 'Confirm',
                onPressed: () {
                  Navigator.pop(context);
                  double amount = double.parse(controller.text);
                  setState(() {
                    currencyData.transfer(
                        widget.currencyName, widget.exchangeRate, amount);
                  });
                },
              ),
            ],
          );
        });
  }
}

class AlertDialogButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AlertDialogButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}