import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_bank/models/pot_data.dart';
import 'package:provider/provider.dart';

class TransferDialogBox extends StatefulWidget {
  final String potName;
  final BuildContext context;

  TransferDialogBox({this.potName, this.context});

  @override
  _TransferDialogBoxState createState() => _TransferDialogBoxState();
}

class _TransferDialogBoxState extends State<TransferDialogBox> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PotData>(
        builder: (context, potData, child) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Enter amount to transfer to pot',
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
                    potData.transfer(
                        widget.potName, amount);
                  });
                },
              ),
            ],
          );
        });
  }
}

class AddPotDialogBox extends StatefulWidget {
  final String potName;
  final BuildContext context;

  AddPotDialogBox({this.potName, this.context});

  @override
  _AddPotDialogBoxState createState() => _AddPotDialogBoxState();
}

class _AddPotDialogBoxState extends State<AddPotDialogBox> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PotData>(
        builder: (context, potData, child) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Enter name of new pot!',
                        hintText: 'eg. Savings'),
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
                  setState(() {
                    potData.addPot(controller.text);
                  });
                },
              ),
            ],
          );
        });
  }
}

class EditPotDialogBox extends StatefulWidget {
  final String potName;
  final BuildContext context;

  EditPotDialogBox({this.potName, this.context});

  @override
  _EditPotDialogBoxState createState() => _EditPotDialogBoxState();
}

class _EditPotDialogBoxState extends State<EditPotDialogBox> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PotData>(
        builder: (context, potData, child) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Rename pot',
                        hintText: 'eg. Savings'),
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
                  setState(() {
                    potData.editPot(widget.potName, controller.text);
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