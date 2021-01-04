import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macro_bank/models/pot.dart';
import 'package:audioplayers/audio_cache.dart';

//The notifyListeners() function that is called in these functions is very important
//Since the other classes are subscribed to listen to changes within the potData class
//the notifyListeners() function will tell the listeners/subscribers that there has been a change.
//This will then update the state of everything that is subscribed to potData and rebuild
//any widget as if using setState(){}, PotData extends ChangeNotifier for this purpose.

class PotData extends ChangeNotifier{
  //Initialises the audio player
  final player = AudioCache();

  //User's current account
  Pot _mainPot = Pot('Current Account', 5000.0);

  //List of pots customer can add to, delete or edit
  List<Pot> _pots = [
    Pot('Rent', 1200.0),
    Pot('Fun', 0.0),
  ];

  List<Pot> get pots{
    return _pots;
  }

  Pot get mainPot{
    return _mainPot;
  }

  //Mimics the process of sending money to another account
  //a sound will play when the function is run.
  void sendMoney(double amount){
    _mainPot.currentAmount -= amount;
    notifyListeners();
    print('success');
    player.play('cash-register.mp3');
  }

  //Adds a pot to the list of pots
  void addPot(String potName){
    Pot newPot = Pot(potName, 0.0);
    _pots.add(newPot);
    notifyListeners();
  }

  //Lets the user edit the name of a pot
  void editPot(String potName, String newPotName){
    for(Pot pot in _pots){
      if(pot.name == potName){
        pot.name = newPotName;
      }
    }
    notifyListeners();
  }

  //Lets the user delete a pot, if the pot has money in it, it will automatically
  //be transferred back to the main pot.
  void deletePot(String potName){
    for(Pot pot in _pots){
      if(pot.name == potName){
        _mainPot.currentAmount += pot.currentAmount;
      }
    }
    _pots.removeWhere((element) => element.name == potName);
    notifyListeners();
  }

  //Transfers money from the main pot to any pot the user chooses.
  void transfer(String potName, double amount){
    for(Pot pot in _pots){
      if(pot.name == potName){
        pot.currentAmount += amount;
      }
    }
    _mainPot.currentAmount -= amount;
    notifyListeners();
    print('success');
    player.play('cash-register.mp3');
  }

  //A user may wish to clear a pot of any funds, this will return it to the main po
  void transferToMainPot(String potName){
    for(Pot pot in _pots){
      if(pot.name == potName){
        _mainPot.currentAmount += pot.currentAmount;
        pot.currentAmount -= pot.currentAmount;
      }
    }
    notifyListeners();
  }
}