import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_bank/models/pot_data.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatefulWidget {
  static String id = 'transfer_screen';

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _controller = TextEditingController();
  String _selected = 'UK';

  @override
  Widget build(BuildContext context) {
    return Consumer<PotData>(builder: (context, potsData, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Here you can transfer and exchange funds between your bank accounts.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton<String>(
                      value: _selected,
                      dropdownColor: Colors.deepPurpleAccent,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      items: <String>['UK', 'German', 'Swiss', 'Danish']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selected = newValue;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Enter amount you wish to send',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.zero,
                                    bottomRight: Radius.zero),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              bottomLeft: Radius.zero,
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: MaterialButton(
                            elevation: 5,
                            height: 60,
                            onPressed: () {
                              setState(() {
                                potsData.sendMoney(double.parse(_controller.text));
                              });
                              Navigator.pop(context);
                            },
                            color: Colors.deepPurpleAccent,
                            child: Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
