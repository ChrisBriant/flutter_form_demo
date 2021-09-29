import 'package:flutter/material.dart';
import 'package:formdemo/providers/form_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/form_item.dart';

class FormScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final _form = Provider.of<FormProvider>(context, listen: false);

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('Form is invalid');
      return;
    } else {
      _formKey.currentState!.save();
      print('Form is valid');
      print(_form.getFormValue('exersizeName'));
      print(_form.getFormValue('weight'));
      print(_form.getFormValue('weekday'));
      print(_form.getFormValue('cardio'));
    }
  }

  final Map<String,int> _days = {
    'Sunday' : 0,
    'Monday' : 1,
    'Tuesday' : 2,
    'Wednesday' : 3,
    'Thursday' : 4,
    'Friday' : 5,
    'Saturday' : 6,
  };




    return Scaffold(
      appBar: AppBar(title: Text('Form Example'),),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FormItem(label: 'Excersize', type: 'text',formItem: 'exersizeName',saveAction: _form.addToForm,),
                  FormItem(label: 'Weight', type: 'numeric',formItem: 'weight',saveAction: _form.addToForm,appendText: 'Kilos',),
                  FormItem(label: 'Day of Week:', type: 'choice', formItem: 'weekday', saveAction: _form.addToForm, choices: _days,defaultChoiceValue: 0,),
                  FormItem(label: 'Is exersize cardio', type: 'check', formItem: 'cardio', saveAction: _form.addToForm, defaultCheckValue:false)
                  // DropdownButtonFormField(
                  //   items: _days.entries.map( (e) => DropdownMenuItem(
                  //       child: Text(e.key),
                  //       value: e.value,
                  //     )
                  //   ).toList(), 
                  //   value: _selectedValue,
                  //   onChanged: (val) { _selectedValue = val as int; },
                  //   onSaved:(val) {_form.addToForm('weekday',val ); },
                  // )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveForm, 
            child: Text('Save Details')
          )
        ],
      ),
      
    );
  }
}

