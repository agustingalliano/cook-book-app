import 'package:flutter/material.dart';

typedef OnIngredientCallback = void Function(int index);

class IngredientStepWidget extends StatelessWidget {
  final int index;

  final String ingredientName;
  final OnIngredientCallback onIngredientDeleteCallback;
  final OnIngredientCallback onIngredientEditCallback;

  const IngredientStepWidget({
    required this.index,
    required this.ingredientName,
    required this.onIngredientDeleteCallback,
    required this.onIngredientEditCallback,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backColor = Colors.white;
    if ((index % 2) == 1) {
      backColor = Colors.grey[300] as Color;
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: backColor),
      child: ListTile(
        leading: Text(
          "${index + 1}",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        title: Text(
          ingredientName,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                onIngredientEditCallback(index);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onIngredientDeleteCallback(index);
              },
            )
          ],
        ),
      ),
    );
  }
}