import 'package:flutter/material.dart';

class AlignmentDemo extends StatelessWidget {
  const AlignmentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alignment Demo'),
      ),
      body: Center(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.end,
          //mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              color: Colors.red,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.yellow,
            ),
            Container(
              width: 70,
              height: 70,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}