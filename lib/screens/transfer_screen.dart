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
  double _exchanged = 0.0;
  double _exchangeRate = 0.90;

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
                    Text('Linked account: UK'),
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
                            //These next few lines make it so the keyboard display will be a number pad and only accept digits.
                            //This is also seen in the alert_dialog_box file with the dialog box classes.
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value){
                              setState(() {
                                //This updates the _exchanged variable every time the textfield is changed,
                                //giving us a real time conversion of the amount being sent.
                                _exchanged = double.parse(value) * _exchangeRate;
                              });
                            },
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
                                //double.parse(_controller.text) will take what resides in the textfield at the time and convert it to a double
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'They will receive: £$_exchanged',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                    ),),
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
