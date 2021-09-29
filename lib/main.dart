import 'package:flutter/material.dart';
import 'package:formdemo/providers/form_provider.dart';
import 'package:provider/provider.dart';

import '../screens/form_screen.dart';

void main() {
  runApp(FormDemo());
}

class FormDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => FormProvider({
          'exersizeName' : '',
          'reps' : 0,
          'weight' : 1.5,
          'metric' : 'kilos',
          'weekday' : 0,
          'cardio' : false
        })),
      ],
      child: MaterialApp(
        title: 'Form Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FormScreen(),
      )
    );
  }
}
