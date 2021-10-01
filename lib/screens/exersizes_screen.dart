import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';

class ExersizesScreen extends StatelessWidget {
  static const routeName = '/exersize';


  @override
  Widget build(BuildContext context) {
    _printDB() async {
      List<Map<String, dynamic>> data = await DBHelper.getData('exerscises');
      print(data);

    }

    _printDB();


    Map<int,String> _weekDays_long = {
      0: 'Sunday',
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
    };

    Map<int,String> _weekDays = {
      0: 'Sun',
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
    };

    return Scaffold(
      appBar: AppBar(title: Text('Exersizes'),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Exersizes'),
            FutureBuilder(
              future: DBHelper.getData('exerscises'),
              builder: (ctx, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) => snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(snapshot.data![i]['exersizeName']),
                    subtitle: snapshot.data![i]['iscardio'] == 1 ? Text('Type: cardio') : Text('Type: weights'),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: FittedBox(child: Text(_weekDays[snapshot.data![i]['weekday']]!)),

                    ),
                    onTap: () {print(snapshot.data![i]['exersizeName']);},
                  )
                )
              )
          ],),
      ),
      
    );
  }
}