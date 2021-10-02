import 'package:flutter/material.dart';
import 'package:formdemo/screens/exersizes_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/form_provider.dart';
import '../widgets/form_item.dart';
import '../providers/db_provider.dart';

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
      print(_form.getFormValue('weekday'));
      print(_form.getFormValue('cardio'));
      double _weightVal = 0.0;
      int _repsVal = 0;
      if(!_form.getFormValue('cardio')) {
        print('processing');
        _repsVal = int.parse(_form.getFormValue('reps'));
        _weightVal = double.parse(_form.getFormValue('weight'));
      }

      try {
        DBProvider.insert('exerscises', {
          'id' : uuid.v4(),
          'exersizeName' : _form.getFormValue('exersizeName'),
          'reps' : _repsVal,
          'weight' : _weightVal,
          'weekday' : _form.getFormValue('weekday'),
          'iscardio' : _form.getFormValue('cardio') as bool ? 1 : 0
        });
      } catch(err) {
        print(err);
      }
      //Reset form and Exit
      _form.resetFormData({
          'exersizeName' : '',
          'reps' : 0,
          'weight' : 0.0,
          'metric' : 'kilos',
          'weekday' : 0,
          'cardio' : false
      });
      Navigator.of(context).pop();
    }
  }

  _printDB() async {
    List<Map<String, dynamic>> data = await DBProvider.getData('exerscises');
    print(data);

  }

  _printDB();

  //print(DBProvider.getData('exerscises'));



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

