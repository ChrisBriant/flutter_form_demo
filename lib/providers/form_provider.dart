import 'package:flutter/widgets.dart';

class FormProvider with ChangeNotifier{
  Map<String,dynamic> _formData = {};

  FormProvider(
    this._formData
  );

  addToForm(String key,dynamic val) {
    print('Adding to form');
    _formData[key] = val;
    notifyListeners();
  }

  dynamic getFormValue(String key) {
    return _formData[key];
  }

  bool fieldChangedValue(String key, dynamic val) {
    notifyListeners();
    return true;
  }

}