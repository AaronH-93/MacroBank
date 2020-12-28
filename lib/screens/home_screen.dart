import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:macro_bank/components/rounded_button.dart';
import 'package:macro_bank/models/currency_data.dart';
import 'package:macro_bank/screens/add_currency_screen.dart';
import 'package:macro_bank/screens/take_picture_screen.dart';
import 'package:provider/provider.dart';
import 'package:macro_bank/components/alert_dialog_box.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: CameraScreen.userHasAvatar ? Image.file(File(CameraScreen.userAvatar)) : Image.asset(CameraScreen.blankAvatar)
                          ),
                        ),
                        FlatButton(
                          color: Colors.indigoAccent,
                          onPressed: () {
                            Navigator.pushNamed(context, CameraScreen.id);
                          },
                          child: Text(
                            'Take Photo',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                        ),
                        items: currencyData.userCurrencies.map((item) =>
                            Container(
                              child: Column(
                                children: [
                                  Text(item.name.toString()),
                                  Expanded(
                                      child: Container(
                                          height: 200,
                                          width: 200,
                                          child: Image.asset(
                                              item.imageLoc.toString()))),
                                  Text(item.currentAmount.toString()),
                                  RoundedButton(
                                    color: Colors.indigoAccent,
                                    title: 'Transfer',
                                    onPressed: () {
                                      setState(() {
                                        _showTransferDialog(
                                            item.name, item.exchangeRate);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                      color: Colors.indigoAccent,
                      title: 'Add Currency',
                      onPressed: () {
                        Navigator.pushNamed(context, AddCurrencyScreen.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }


  _showTransferDialog(String currencyName, double exchangeRate) async {
    await showDialog<String>(
      context: context,
      child: TransferDialogBox(currencyName: currencyName, exchangeRate: exchangeRate, context: context),
    );
  }
}


