
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Task 1'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // PART 1: STACK WITH SIX CONTAINERS
            const Text(
              'Part 1: Stack with Containers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Container 1: Red
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),

                  // Container 2: Blue
                  Container(
                    width: 90,
                    height: 90,
                    color: Colors.blue,
                  ),

                  // Container 3: Green
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.green,
                  ),

                  // Container 4: Yellow
                  Container(
                    width: 70,
                    height: 70,
                    color: Colors.yellow,
                  ),

                  // Container 5: Black
                  Container(
                    width: 60,
                    height: 60,
                    color: Colors.black,
                  ),

                  // Container 6: Purple
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // PART 2: IMAGE INTEGRATION
            const Text(
              'Part 2: Image Integration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Top: First male picture
            Image.asset(
              'assets/male1.jpg',
              width: 180,
              height: 150,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 15),

            // Middle: Female picture
            Image.asset(
              'assets/female.jpg',
              width: 180,
              height: 150,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 15),

            // Bottom: Second male picture
            Image.asset(
              'assets/male2.jpg',
              width: 180,
              height: 150,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
