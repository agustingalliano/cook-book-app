import 'package:cook_book/src/components/tab_ingredient_widget.dart';
import 'package:cook_book/src/components/tab_preparation_widget.dart';
import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';

class DetailsPage extends StatefulWidget {
  final ServerController serverController;
  final Recipe recipe;

  const DetailsPage(this.serverController, this.recipe, {Key? key})
      : super(key: key);

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  late bool favorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(widget.recipe.name),
                expandedHeight: 320,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(widget.recipe.photo))),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                pinned: true,
                bottom: const TabBar(
                    indicatorWeight: 4,
                    labelColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text("Ingredients",
                          style: TextStyle(fontSize: 18),
                        )),
                      Tab(
                        child: Text("Preparation",
                          style: TextStyle(fontSize: 18),
                        )),
                    ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit)),
                  getFavoriteWidget(),
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.help_outline))
                ],
              )
            ];
          },
          body: TabBarView(
              children: [
                TabIngredientWidget(widget.recipe),
                TabPreparationWidget(widget.recipe)
              ]
            ),
        )
      ),
    );
  }

  Widget getFavoriteWidget() {
    return FutureBuilder<bool>(
        future: widget.serverController.isFavorite(widget.recipe),
        builder: (context, snapshot) {
            if(snapshot.hasData) {
              favorite = snapshot.data!;
              if (favorite) {
                return IconButton(
                    onPressed: () async {
                      await widget.serverController.deleteFavorite(
                          widget.recipe);
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                    icon: const Icon(Icons.favorite));
              } else {
                return IconButton(
                    onPressed: () async {
                      await widget.serverController.addFavorite(widget.recipe);
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                    icon: const Icon(Icons.favorite_border));
              }
            } else {
                return Container(
                  margin: const EdgeInsets.all(15),
                  child: const SizedBox(
                    width: 27,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
            }
        });
  }

}
