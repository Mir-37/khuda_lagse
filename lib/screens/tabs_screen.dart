import 'package:flutter/material.dart';
import 'package:khuda_lagse/data/dummy_data.dart';
import 'package:khuda_lagse/models/meal.dart';
import 'package:khuda_lagse/screens/categories_screen.dart';
import 'package:khuda_lagse/screens/filters_screen.dart';
import 'package:khuda_lagse/screens/meals_screen.dart';
import 'package:khuda_lagse/widget/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _favoriteMeals = [];

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Removed from favorites list');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Added to favorites list!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavorite: (Meal meal) {
        _toggleMealFavoriteStatus(meal);
      },
      availableMeals: availableMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: (Meal meal) {
          _toggleMealFavoriteStatus(meal);
        },
      );
    }

    void setScreen(String identifier) async {
      Navigator.of(context).pop();

      if (identifier == 'filters') {
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
              currentFilters: _selectedFilters,
            ),
          ),
        );

        setState(() {
          _selectedFilters = result ?? kInitialFilters;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          setScreen(identifier);
        },
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
