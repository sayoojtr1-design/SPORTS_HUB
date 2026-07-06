import 'package:flutter/cupertino.dart';

class ObscureProvider extends ChangeNotifier {

  bool isVisible = false;

  void toggleVisibility(){
    isVisible = !isVisible;
    notifyListeners();
  }


}