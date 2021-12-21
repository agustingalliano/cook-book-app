import 'package:cook_book/src/components/my_drawer.dart';
import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';

class HomePage extends StatefulWidget {
  final ServerController serverController;

  const HomePage({Key? key, required this.serverController}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My cookbook"),
      ),
      drawer: MyDrawer(serverController: widget.serverController),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getRecipesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data;
            return ListView.builder(
                itemCount: list!.length,
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
                                icon: const Icon(Icons.favorite),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
