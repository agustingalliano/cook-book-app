import 'package:cook_book/src/components/my_drawer.dart';
import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';


class FavoritePage extends StatefulWidget {
  final ServerController serverController;

  const FavoritePage(this.serverController, {Key? key}) : super(key: key);

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My favorites"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getFavoritesList(),
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
                        "Favorite list is Empty, select the favorite icon on the recipe you want to add.",
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
                                  icon: const Icon(Icons.favorite, color: Colors.red,),
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