import 'package:flutter/material.dart';

class TipCalculator extends ChangeNotifier {
  double _tip = 0;
  double _total = 0;
  double _percentage = 0;
  bool _isCustom = true;
  bool _error = false;

  void setPercentage(double percentage, {bool custom = false}) { 
      _percentage = percentage; 
    _isCustom = custom;
    notifyListeners();
  }

  void calculate(double amount) {

     if (percentage < 100 && percentage > 0) {
      _tip = amount * _percentage / 100;
    _total = amount + _tip;
      _error = false;
    } else {
      _error = true;
    }

   
    notifyListeners();
  }

  double get percentage => _percentage;
  double get tip => _tip;
  double get total => _total;
  bool get isCustom => _isCustom;
    bool get error => _error;

  void reset() {
    _tip = 0;
    _total = 0;
    _percentage = 0;
    _error = false;
    _isCustom = false;
    notifyListeners();
  }
}
