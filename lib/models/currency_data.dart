import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macro_bank/models/currency.dart';

class CurrencyData extends ChangeNotifier{
  List<Currency> _currencies = [
    Currency('Current Account', 5000.0, 0.0, 'assets/images/euro.png'),
    Currency('GBP', 0.0, 1.10, 'assets/images/GBP.png'),
    Currency('DKK', 0.0, 7.45, 'assets/images/DKK.png'),
    Currency('SEK', 0.0, 10.16, 'assets/images/SEK.png'),
    Currency('BGN', 0.0, 1.96, 'assets/images/BGN.png'),
    Currency('CZK', 0.0, 26.32, 'assets/images/CZK.png'),
    Currency('HUF', 0.0, 364.17, 'assets/images/HUF.png'),
    Currency('PLN', 0.0, 4.53, 'assets/images/PLN.png'),
    Currency('RON', 0.0, 4.91, 'assets/images/RON.png')
  ];

  List<Currency> _userCurrencies = [
    Currency('Current Account', 5000.0, 0.0, 'assets/images/euro.png'),
    Currency('GBP', 0.0, 1.10, 'assets/images/GBP.png'),
    Currency('DKK', 0.0, 7.45, 'assets/images/DKK.png')
  ];

  List<Currency> get currencies{
    return _currencies;
  }

  List<Currency> get userCurrencies{
    return _userCurrencies;
  }

  void deleteCurrencyFromUser(Currency currency){
   _userCurrencies.removeWhere((element) => element.name == currency.name);
    notifyListeners();
  }

  void addCurrencyToUser(Currency currency){
    _userCurrencies.add(currency);
    notifyListeners();
  }

  void transfer(String currencyName, double exchangeRate, double amount){
    for(Currency currency in _userCurrencies){
      if(currency.name == currencyName){
        currency.currentAmount += (amount * exchangeRate);
      }
    }
    _userCurrencies[0].currentAmount -= amount;
    notifyListeners();
    print('success');
  }

  List<Currency> generatePotentialCurrencies(){
    List<Currency> potentialCurrencies = _currencies;
    for(Currency currency in _userCurrencies){
      potentialCurrencies.removeWhere((element) => element.name == currency.name);
    }
    return potentialCurrencies;
  }

  List<Currency> generatePotentialRemovableCurrencies(){
    List<Currency> potentialCurrencies = _userCurrencies;
    potentialCurrencies.removeWhere((element) => element.name == "Current Account");
    return potentialCurrencies;
  }
}