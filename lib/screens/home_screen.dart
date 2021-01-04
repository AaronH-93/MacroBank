import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:macro_bank/components/rounded_button.dart';
import 'package:macro_bank/models/pot_data.dart';
import 'package:macro_bank/screens/take_picture_screen.dart';
import 'package:macro_bank/screens/transfer_screen.dart';
import 'package:provider/provider.dart';
import 'package:macro_bank/components/alert_dialog_box.dart';

final player = AudioCache();

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Consumer lets us access the PotData class and listens for changes in the state so it can update the app.
    return Consumer<PotData>(builder: (context, potsData, child) {
      return Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Center(
          child: SafeArea(
            child: Column(
              children: [
                //Sized Boxes are used for spacing.
                SizedBox(
                  height: 10.0,
                ),
                //This row contains the avatar and update photo button, rows and columns can be wrapped
                //each other to provide desired design.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            //ClipRRect and borderRadius give us the circular avatar
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              //the avatar displayed is dependent on the ternary operator
                              //if userHasAvatar is true, it will display the avatar
                              //else it will return a blank avatar image.
                              child: CameraScreen.userHasAvatar
                                  ? Image.file(File(CameraScreen.userAvatar))
                                  : Image.asset(CameraScreen.blankAvatar)),
                        ),
                        FlatButton(
                          color: Colors.deepPurple[400],
                          onPressed: () {
                            //When user taps "update photo" it takes them to the camera screen
                            //so they can take a picture.
                            Navigator.pushNamed(context, CameraScreen.id);
                          },
                          child: Text(
                            'Update Photo',
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
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              //displays the amount in the user's current account
                              '${potsData.mainPot.currentAmount}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: Colors.deepPurple[400],
                              ),
                            ),
                            Text('${potsData.mainPot.name}'),
                            //Tapping the send money button takes the user to the transfer_screen.
                            RoundedButton(
                              color: Colors.deepPurple[400],
                              title: 'Send Money',
                              onPressed: () {
                                Navigator.pushNamed(context, TransferScreen.id);
                                //transfer internationally?
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    //Wrapping these elements in a Material widget lets us use the borderRadius, elevation and color
                    //fields for editing the design of the page.
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      color: Colors.deepPurpleAccent,
                      //CarouselSlider is part of the carousel_slider package and its what gives us the
                      //special animated horizontal scrollview the pots are contained in.
                      //Essentially, for every item in the pots collection, it builds a column widget with information relevant to that item.
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                        ),
                        items: potsData.pots
                            .map(
                              (item) => Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      FlatButton.icon(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            _showEditPotDialog(item.name);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        label: Text(''),
                                      ),
                                      Text(
                                        item.name.toString(),
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      FlatButton.icon(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            potsData.deletePot(item.name);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        label: Text(''),
                                      ),
                                    ],
                                  ),
                                  Text(item.currentAmount.toString(), style: TextStyle(color: Colors.white, fontSize: 20),),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        FlatButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              potsData
                                                  .transferToMainPot(item.name);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                          label: Text(''),
                                        ),
                                        FlatButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              _showTransferDialog(item.name);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          label: Text(''),
                                        ),

                                      ],
                                    ),
                                  ),
                                  RoundedButton(
                                    color: Colors.deepPurple[300],
                                    title: 'Add Pot',
                                    onPressed: () {
                                      setState(() {
                                        _showAddPotDialog();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  //Series of functions that return specific dialog boxes used for different parts of the app.
  _showTransferDialog(String potName) async {
    await showDialog<String>(
      context: context,
      child: TransferDialogBox(potName: potName, context: context),
    );
  }

  _showAddPotDialog() async {
    await showDialog<String>(
      context: context,
      child: AddPotDialogBox(context: context),
    );
  }

  _showEditPotDialog(String potName) async {
    await showDialog<String>(
      context: context,
      child: EditPotDialogBox(potName: potName, context: context),
    );
  }
}
