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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text('hello') ),
                  // itemBuilder: (ctx, i) => Row(
                  //   //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     //Text(snapshot.data![i]['exersizeName'])
                  //   ],
                  // )
                )
              )
          ],),
      ),
      
    );
  }
}