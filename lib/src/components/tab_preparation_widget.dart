import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class TabPreparationWidget extends StatelessWidget {
  final Recipe recipe;

  const TabPreparationWidget(this.recipe, {Key? key}) : super(key: key);

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
              "Preparation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 10,
        ),
        Column(
            children: List.generate(recipe.steps.length, (index) {
              String step = recipe.steps[index];
              int stepNumber = index+1;
              return ListTile(
                leading: SizedBox(
                  child: Text(
                    stepNumber.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                title: Text(step),
              );
            }))
      ],
    );
  }
}