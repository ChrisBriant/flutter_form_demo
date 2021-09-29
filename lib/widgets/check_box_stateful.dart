import 'package:flutter/material.dart';

class CheckBoxStateful extends StatefulWidget {
  final bool defaultCheckState;
  final String label;
  final Function saveAction;

  const CheckBoxStateful(this.defaultCheckState, this.label,this.saveAction);


  @override
  _CheckBoxStatefulState createState() => _CheckBoxStatefulState();
}

class _CheckBoxStatefulState extends State<CheckBoxStateful> {
  bool _checkValue = false;

  @override
  void initState() {
    super.initState();
    _checkValue = widget.defaultCheckState;
  }
  

  @override
  Widget build(BuildContext context) {
        //bool _checkValue = false;// = widget.defaultCheckState;
        return Row(
          children: [
            Checkbox(
              value: _checkValue, 
              onChanged: (val) {
                setState(() {
                  _checkValue = val!;
                });
              },
            ),
            Text(widget.label),
          ],

        );
  }
}