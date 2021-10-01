import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/form_provider.dart';
import '../widgets/form_item.dart';
import '../helpers/db_helper.dart';

class FormScreen extends StatelessWidget {
  static const routeName = '/form';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final _form = Provider.of<FormProvider>(context, listen: true);

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print('Form is invalid');
      return;
    } else {
      _formKey.currentState!.save();
      var uuid = Uuid();
      
      print('Form is valid');
      print(uuid.v4());
      print(_form.getFormValue('exersizeName'));
      print(_form.getFormValue('weight'));
      print(_form.getFormValue('weekday'));
      print(_form.getFormValue('cardio'));
      print(int.parse(_form.getFormValue('reps')));
      try {
        DBHelper.insert('exerscises', {
          'id' : uuid.v4(),
          'exersizeName' : _form.getFormValue('exersizeName'),
          'reps' : int.parse(_form.getFormValue('reps')),
          'weight' : double.parse(_form.getFormValue('weight')),
          'weekday' : _form.getFormValue('weekday'),
          'iscardio' : _form.getFormValue('cardio') as bool ? 1 : 0
        });
      } catch(err) {
        print(err);
      }
    }
  }

  _printDB() async {
    List<Map<String, dynamic>> data = await DBHelper.getData('exerscises');
    print(data);

  }

  _printDB();

  //print(DBHelper.getData('exerscises'));



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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                    FormItem(label: 'Excersize', type: 'text',formItem: 'exersizeName',saveAction: _form.addToForm, ),
                    FormItem(label: 'Is exersize cardio', type: 'check', formItem: 'cardio', saveAction: _form.addToForm, defaultCheckValue:_form.getFormValue('cardio'),),
                    !_form.getFormValue('cardio')
                    ? FormItem(label: 'Weight', type: 'numeric',formItem: 'weight',saveAction: _form.addToForm,appendText: 'Kilos',) : SizedBox.shrink(),
                    !_form.getFormValue('cardio')
                    ? FormItem(label: 'Reps', type: 'numeric',formItem: 'reps',saveAction: _form.addToForm,) : SizedBox.shrink(),
                    FormItem(label: 'Day of Week:', type: 'choice', formItem: 'weekday', saveAction: _form.addToForm, choices: _days,defaultChoiceValue: 0,),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _saveForm, 
              child: Text('Save Details')
            )
          ],
        ),
      ),
      
    );
  }
}

