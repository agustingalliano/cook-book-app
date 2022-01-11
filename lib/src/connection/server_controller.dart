import 'package:flutter/cupertino.dart';
import 'package:flutter_modulo1_fake_backend/modulo1_fake_backend.dart' as server;
import 'package:flutter_modulo1_fake_backend/models.dart';

class ServerController {

  late User loggedUser;

  void init (BuildContext context) {
      server.generateData(context);
  }

  Future<User> login (String userName, String password) async{
    return await server.backendLogin(userName, password);
  }

  Future<bool> addUser(User user) async{
    return await server.addUser(user);
  }

  Future<List<Recipe>> getRecipesList() async {
    return await server.getRecipes();
  }

  Future<bool> updateUser(User user) async {
    loggedUser = user;
    return await server.updateUser(user);
  }

  Future<List<Recipe>> getFavoritesList() async {
    return await server.getFavorites();
  }

  Future<Recipe> addFavorite(Recipe recipe) async{
    return await server.addFavorite(recipe);
  }

  Future<bool> isFavorite(Recipe recipe) async {
    return await server.isFavorite(recipe);
  }

  Future<bool> deleteFavorite(Recipe recipe) async{
     return await server.deleteFavorite(recipe);
  }
}