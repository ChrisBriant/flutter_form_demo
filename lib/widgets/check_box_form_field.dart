import 'package:flutter/material.dart';


class CheckboxFormField extends FormField<bool> {
  //final Widget title;
  //final Function onSaved;
  //final bool validator;

  CheckboxFormField(
      { required Widget title,
      required FormFieldSetter<bool> onSaved,
      required Function changeFunction,
      //required Function onChanged,
      //required FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            //validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                //onChanged: state.didChange,
                onChanged:(val) { 
                  state.didChange(val);
                  changeFunction('cardio',val);
                } ,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) =>  Text(
                          state.errorText!,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}