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


    Map<int,String> _weekDays = {
      0: 'Sunday',
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
    };

    return Scaffold(
      appBar: AppBar(title: Text('Exersizes'),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Exersizes'),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('Col1')
                    ),
                    Text('Col2'),
                    Text('Col3'),
                    Text('Col4'),
                  ]
                )
              ],
            ),
            FutureBuilder(
              future: DBHelper.getData('exerscises'),
              builder: (ctx, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) => snapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => Table(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TableRow(
                        children: [
                          Text(snapshot.data![i]['exersizeName']),
                          Text(snapshot.data![i]['reps'].toString()),
                          Text(snapshot.data![i]['weight'].toString()),
                          Text(_weekDays[snapshot.data![i]['weekday']]!)
                        ],
                      ),
                    ],
                  )
                )
              )
          ],),
      ),
      
    );
  }
}