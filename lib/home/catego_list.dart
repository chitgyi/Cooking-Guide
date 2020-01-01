import 'dart:math';

import 'package:cooking_guide/components/FoodGroup.dart';
import 'package:cooking_guide/models/foodtype.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final FoodMenu menu;
  CategoryItem(this.menu);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.primaries[Random().nextInt(8)],
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext cxt) => FoodGroup(menu)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                menu.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    );
  }
}
