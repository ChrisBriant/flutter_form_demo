import 'package:flutter/material.dart';
import 'package:formdemo/widgets/check_box_form_field.dart';
//import 'package:formdemo/widgets/check_box_stateful.dart';
//import 'package:checkbox_formfield/checkbox_formfield.dart';

import '../validators/validators.dart';

class FormItem extends StatelessWidget {
  final String label;
  final String type;
  final String formItem;
  final int defaultChoiceValue;
  final Map<String,int> choices;
  final String appendText;
  final bool defaultCheckValue;
  final Function saveAction;
  //final Function fieldChanged;

  const FormItem({
    required this.label,
    required this.type,
    required this.formItem,
    required this.saveAction,
    //required this.fieldChanged,
    this.defaultChoiceValue = 0,
    this.choices = const {},
    this.appendText = '',
    this.defaultCheckValue = false,
    Key? key,
  }) : super(key: key);

  TextInputType _getKeyboardType() {
    switch (type) {
      case 'email' :
        return TextInputType.emailAddress;
      case 'numeric' :

        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  Function _getFormValidator() {
    switch (type) {
      case 'email' :
        return Validators.validEmail;
      case 'numeric' :
        return Validators.validIsNumeric;
      default:
        return Validators.validHasText;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _selectedValue = defaultChoiceValue;
    var _checkValue = defaultCheckValue;

    switch (type) {
      case 'choice':
        return DropdownButtonFormField(
            decoration: InputDecoration(labelText: label),
            items: choices.entries.map( (e) => DropdownMenuItem(
              child: Text(e.key),
              value: e.value,
            )
            ).toList(), 
            value: _selectedValue,
            onChanged: (val) { _selectedValue = val as int; },
            
            onSaved:(value) { saveAction(formItem,value); },
        );
      case 'check':
        // return Row(
        //   children: [
        //     Checkbox(
        //       value: _checkValue, 
        //       onChanged: (val) {_checkValue = val!;},
        //     ),
        //     Text(label),
        //   ],
          

        //);
        //return CheckBoxStateful(false, label,saveAction);
        // return CheckboxListTileFormField(
        //   title: Text('Check!'),
        //   onSaved: (bool value) {print(value);},
        //   validator: (bool value) {
        //     if (value) {
        //       return null;
        //     } else {
        //       return 'False!';
        //     }
        //   },
        // );
        return CheckboxFormField(
          title: Text(label), 
          //onSaved: (value) {saveAction(formItem,value);},
          onSaved: (_) {},
          //onChanged: (value) {saveAction(formItem,value);}
          changeFunction: saveAction,
          //onChanged: saveAction,
          //onChanged: (value) {notifyListen}
          //validator: (value) {retu}
        );
      default:
        if(appendText == '') {
          return TextFormField(
            decoration: InputDecoration(labelText: label),
            keyboardType: _getKeyboardType(),
            validator: (value) => _getFormValidator()(value),
            onSaved: (value) { saveAction(formItem,value); },
            onTap: () {print(TextInputType.emailAddress);},
          );
        } else {
          //Change output so that the text is disabled next to the text field
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(labelText: label),
                  keyboardType: _getKeyboardType(),
                  validator: (value) => _getFormValidator()(value),
                  onSaved: (value) { saveAction(formItem,value); },
                  onTap: () {print(TextInputType.emailAddress);},
                ),
              ),
              Text('Kilos',)
            ],
          );
        }
    }  


  }
}