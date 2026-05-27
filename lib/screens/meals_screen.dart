import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khuda_lagse/models/meal.dart';

class MealsScreen extends StatelessWidget {
  final List<Meal> meals;
  final String title;

  const MealsScreen({super.key, required this.meals, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
