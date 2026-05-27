import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          const Text('1'),
          const Text('2'),
          const Text('3'),
          const Text('4'),
          const Text('5'),
          const Text('6'),
          const Text('7'),
          const Text('8'),
          const Text('9'),
          const Text('10'),
        ],
      ),
    );
  }
}
