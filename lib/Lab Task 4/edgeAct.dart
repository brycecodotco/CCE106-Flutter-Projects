import 'package:flutter/material.dart';

class edgeAct extends StatelessWidget {
  const edgeAct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EdgeInsets Demo'),
      ),
      body: Center(
        child: Column (
          children: [
            //EdgeInsets.all(30)
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.red,
                child: Text('EdgeInsets.all(30)'),
              ),
            ),
            const SizedBox(height:30),

            //EdgeInsets.symmetric(horizontal: 30)
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                color: Colors.yellow,
                child: Text('EdgeInsets.symmetric(horizontal: 40, vertical: 10)'),
              ),
            ),

            const SizedBox(height:30),
            //EdgeInsets.only(left: 30, top: 10, right:5, bottom: 20)
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.only(left: 30, top: 10, right:5, bottom: 20),
                color: Colors.blue,
                child: Text('EdgeInsets.only(left: 30, top: 10, right:5, bottom: 20)'),
              ),
            ),

            const SizedBox(height:30),
            //EdgeInsets.LTRB()
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
                color: Colors.green,
                child: Text('EdgeInsets.fromLTRB(10, 20, 30, 40)'),
              ),
            ),
          ],
        ),
      )
    );
  }
}