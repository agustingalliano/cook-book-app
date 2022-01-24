import 'dart:io';

import 'package:cook_book/src/components/image_picker_widget.dart';
import 'package:cook_book/src/components/ingredient_step_widget.dart';
import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  ServerController serverController;
  BuildContext context;

  AddRecipePage(this.serverController, this.context, {Key? key})
      : super(key: key);

  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "", description = "";
  File photoFile = File("");
  File imageFile = File("");
  List<String> ingredientsList = [], stepsList = [];
  bool saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              ImagePickerWidget(
                imageFile: imageFile,
                onImageSelected: (XFile file) {
                  setState(() {
                    imageFile = File(file.path);
                  });
                },
              ),
              SizedBox(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (_formKey.currentState != null) _save(context);
                        },
                        icon: const Icon(Icons.save))
                  ],
                ),
                height: kToolbarHeight + 25,
              ),
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 260, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 20),
                        child: ListView(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Recipe name: "),
                              onSaved: (value) {
                                name = value!;
                              },
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return "This field is required";
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Description"),
                              onSaved: (value) {
                                name = value!;
                              },
                              validator: (value) {
                                if (value != null) {
                                  if (value.isEmpty) {
                                    return "This field is required";
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: const Text("Ingredients"),
                              trailing: FloatingActionButton(
                                heroTag: "uno",
                                child: const Icon(Icons.add),
                                onPressed: () {
                                  _ingredientDialog(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            getIngredientsList(),
                            const SizedBox(
                              height: 20,
                            ),
                            ListTile(
                              title: const Text("Steps"),
                              trailing: FloatingActionButton(
                                heroTag: "uno",
                                child: const Icon(Icons.add),
                                onPressed: () {
                                  _stepDialog(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            getStepsList(),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ));
  }

  void questionDialog(BuildContext context, String message, VoidCallback onOk) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("NO"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text("YES"),
                onPressed: () {
                  Navigator.pop(context);
                  onOk();
                },
              ),
            ],
          );
        });
  }

  void _onStepDelete(int index) {
    questionDialog(context, "Are you sure you want to delete the step?", () {
      setState(() {
        stepsList.removeAt(index);
      });
    });
  }

  void _onStepEdit(int index) {
    final step = stepsList[index];
    _stepDialog(context, step: step, index: index);
  }

  void _onIngredientDelete(int index) {
    questionDialog(context, "Are you sure you want to delete the ingredient?", () {
      setState(() {
        ingredientsList.removeAt(index);
      });
    });
  }

  void _onIngredientEdit(int index) {
    final ingredient = ingredientsList[index];
    _ingredientDialog(context, ingredient: ingredient, index: index);
  }

  void _showSnackBar(String message, {Color backColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backColor,
      ),
    );
  }

  Widget getIngredientsList() {
    if (ingredientsList.isEmpty) {
      return const Text(
        "Empty list",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      return Column(
        children: List.generate(ingredientsList.length, (index) {
          String ingredient = ingredientsList[index];
          return IngredientStepWidget(
            index: index,
            ingredientName: ingredient,
            onIngredientDeleteCallback: _onIngredientDelete,
            onIngredientEditCallback: _onIngredientEdit,
          );
        }),
      );
    }
  }

  Widget getStepsList() {
    if (stepsList.isEmpty) {
      return const Text(
        "Empty List",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      return Column(
        children: List.generate(stepsList.length, (index) {
          final ingredient = stepsList[index];
          return IngredientStepWidget(
            index: index,
            ingredientName: ingredient,
            onIngredientDeleteCallback: _onStepDelete,
            onIngredientEditCallback: _onStepEdit,
          );
        }),
      );
    }
  }

  void _ingredientDialog(BuildContext context,
      {String? ingredient, int? index}) {
    final textController = TextEditingController(text: ingredient);
    final editing = ingredient != null;
    final onSave = () {
      final text = textController.text;
      if (text.isEmpty) {
        _showSnackBar("Empty name!", backColor: Colors.orange);
      } else {
        setState(() {
          if (editing) {
            ingredientsList[index as int] = text;
          } else {
            ingredientsList.add(text);
          }
          Navigator.pop(context);
        });
      }
    };
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                editing ? "Editing ingredient" : "Adding ingredient"),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: "Ingredient"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text(editing ? "Update" : "Save"),
                onPressed: onSave,
              ),
            ],
          );
        });
  }

  void _stepDialog(BuildContext context, {String? step, int? index}) {
    final textController = TextEditingController(text: step);
    final editing = step != null;
    final onSave = () {
      final text = textController.text;
      if (text.isEmpty) {
        _showSnackBar("Empty step", backColor: Colors.orange);
      } else {
        setState(() {
          if (editing) {
            stepsList[index as int] = text;
          } else {
            stepsList.add(text);
          }
          Navigator.pop(context);
        });
      }
    };

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(editing ? "Editing step" : "Adding step"),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Paso",
              ),
              textInputAction: TextInputAction.newline,
              maxLines: 6,
              //onEditingComplete: onSave,
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text(editing ? "Update" : "Save"),
                onPressed: onSave,
              ),
            ],
          );
        });
  }

  _save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (imageFile.path.isEmpty) {
        _showSnackBar("Empty photo!");
        return;
      }
      if (ingredientsList.isEmpty) {
        _showSnackBar("There are no ingredients!");
        return;
      }
      if (stepsList.isEmpty) {
        _showSnackBar("There are no steps!");
        return;
      }

      Recipe recipe = Recipe(
          name: name,
          description: description,
          photo: imageFile,
          ingredients: ingredientsList,
          steps: stepsList,
          user: widget.serverController.loggedUser,
          date: DateTime.now());

      final savedRecipe = await widget.serverController.addRecipe(recipe);

      if (savedRecipe != null) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Recipe saved successfully"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              );
            });
      } else {
        _showSnackBar("The recipe was not saved correctly");
      }

    }
  }
}
