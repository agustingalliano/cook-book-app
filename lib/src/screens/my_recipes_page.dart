import 'package:cook_book/src/components/my_drawer.dart';
import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';


class MyRecipesPage extends StatefulWidget {
  final ServerController serverController;

  const MyRecipesPage(this.serverController, {Key? key}) : super(key: key);

  @override
  MyRecipesPageState createState() => MyRecipesPageState();
}

class MyRecipesPageState extends State<MyRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My recipes"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getUserRecipesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data;
            if(list!.isEmpty) {
              return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          size: 120,
                          color: Colors.grey[300],
                        ),
                        const Text(
                          "No recipe found from the library, you can add a recipe from the main screen.",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
              );
            }
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Recipe recipe = list[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Card(
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(recipe.photo),
                                  fit: BoxFit.cover,
                                )
                            ),
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              color: Colors.black.withOpacity(0.35),
                              child: ListTile(
                                title: Text(
                                  recipe.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                                subtitle: Text(
                                  recipe.user.nickname,
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.favorite_border, color: Colors.red,),
                                  onPressed: () {
                                  },
                                  iconSize: 32,
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}