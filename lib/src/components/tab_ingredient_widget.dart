import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class TabIngredientWidget extends StatelessWidget {
  final Recipe recipe;

  const TabIngredientWidget(this.recipe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        children: [
          Title(
              color: Colors.black,
              child: Text(
                recipe.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          Text(recipe.description),
          const SizedBox(
            height: 10,
          ),
          Title(
              color: Colors.black,
              child: const Text(
                "Ingredients",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          Column(
              children: List.generate(recipe.ingredients.length, (index) {
                String ingredient = recipe.ingredients[index];
                return ListTile(
                  leading: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(ingredient),
                );
              }))
        ],
      );
  }
}
