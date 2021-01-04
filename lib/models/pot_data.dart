import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macro_bank/models/pot.dart';
import 'package:audioplayers/audio_cache.dart';


class PotData extends ChangeNotifier{
  final player = AudioCache();

  Pot _mainPot = Pot('Current Account', 5000.0);

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

  void sendMoney(double amount){
    _mainPot.currentAmount -= amount;
    notifyListeners();
    print('success');
    player.play('cash-register.mp3');
  }

  void addPot(String potName){
    Pot newPot = Pot(potName, 0.0);
    _pots.add(newPot);
    notifyListeners();
  }

  void editPot(String potName, String newPotName){
    for(Pot pot in _pots){
      if(pot.name == potName){
        pot.name = newPotName;
      }
    }
    notifyListeners();
  }

  void deletePot(String potName){
    for(Pot pot in _pots){
      if(pot.name == potName){
        _mainPot.currentAmount += pot.currentAmount;
      }
    }
    _pots.removeWhere((element) => element.name == potName);
    notifyListeners();
  }

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