
import 'package:flutter/material.dart';

class Pavlova extends StatelessWidget {
  const Pavlova({super.key});

  final String description =
      "Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. "
      "It features a crisp crust and soft, light inside, usually topped with fruit and whipped cream.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App Bar Codotco'),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: [
          buildColumn(),
          const SizedBox(height: 10),
          buildStar(4, 170),
          const SizedBox(height: 10),
          buildRowTabs(),
        ],
      ),
    );
  }

  Widget buildStar(int rating, int reviews) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 1; i <= rating; i++)
            const Icon(
              Icons.star,
              color: Colors.purple,
              size: 30,
            ),
          for (int i = 1; i <= (5 - rating); i++)
            const Icon(
              Icons.star,
              color: Colors.grey,
              size: 30,
            ),
          const SizedBox(width: 20),
          Text(
            '$reviews Reviews',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget buildIconTab(IconData iconVal, String title, String time) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconVal, color: Colors.purple),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );

  Widget buildRowTabs() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildIconTab(Icons.kitchen, 'PREP:', '25 min'),
          buildIconTab(Icons.timer, 'COOK:', '1 hr'),
          buildIconTab(Icons.restaurant, 'FEEDS:', '4-6'),
        ],
      );

  Widget buildColumn() => Column(
        children: [
          Image.asset(
            'assets/pavlova.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          const Text(
            'Ube Pavlova',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      );
}
