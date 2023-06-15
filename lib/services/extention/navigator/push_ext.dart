import 'package:flutter/material.dart';

extension Nav on BuildContext {
  //_______________________ push page extention ______________________
  push({required Widget view}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => view));
  }

  //_______________________ push and remove page extention ______________________
  pushAndRemove({required Widget view}) {
    Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (context) => view), (route) => false);
  }
}
