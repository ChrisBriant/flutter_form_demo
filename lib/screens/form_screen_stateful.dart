import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/check_box_form_field.dart';
import '../providers/form_provider.dart';
import '../widgets/form_item.dart';
import '../helpers/db_helper.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('I changed dependancies');
  }

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
      print(_form.getFormValue('reps'));
      // DBHelper.insert('exerscises', {
      //   'id' : uuid.v4(),
      //   'exersizeName' : _form.getFormValue('exersizeName'),
      //   'reps' : _form.getFormValue('reps') as int,
      //   'weight' : _form.getFormValue('weight') as double,
      //   'weekday' : _form.getFormValue('weekday') as int,
      //   'iscardio' : _form.getFormValue('cardio') as bool ? 1 : 0
      // });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormItem(label: 'Excersize', type: 'text',formItem: 'exersizeName',saveAction: _form.addToForm, ),
                    FormItem(label: 'Is exersize cardio', type: 'check', formItem: 'cardio', saveAction: _form.addToForm, defaultCheckValue:false,),
                    _form.getFormValue('cardio') as bool 
                    ? FormItem(label: 'Weight', type: 'numeric',formItem: 'weight',saveAction: _form.addToForm,appendText: 'Kilos',) : SizedBox.shrink(),
                    _form.getFormValue('cardio') as bool
                    ? FormItem(label: 'Reps', type: 'numeric',formItem: 'reps',saveAction: _form.addToForm,) : SizedBox.shrink(),
                    FormItem(label: 'Day of Week:', type: 'choice', formItem: 'weekday', saveAction: _form.addToForm, choices: _days,defaultChoiceValue: 0,),
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
      ),
      
    );
  }
}

