import 'package:cook_book/src/connection/server_controller.dart';
import 'package:cook_book/src/screens/add_recipe_page.dart';
import 'package:cook_book/src/screens/details_page.dart';
import 'package:cook_book/src/screens/home_page.dart';
import 'package:cook_book/src/screens/login_page.dart';
import 'package:cook_book/src/screens/my_favorites_page.dart';
import 'package:cook_book/src/screens/my_recipes_page.dart';
import 'package:cook_book/src/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan[300],
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return LoginPage(_serverController, context);
            case "/home":
              User userLogged = settings.arguments as User;
              _serverController.loggedUser = userLogged;
              return HomePage(
                serverController: _serverController,
              );
            case "/register":
              User loggedUser = settings.arguments as User;
              return RegisterPage(_serverController, context, loggedUser);
            case "/favorites":
              return FavoritePage(_serverController);
            case "/my_recipes":
              return MyRecipesPage(_serverController);
            case "/details":
                Recipe recipe = settings.arguments as Recipe;
                return DetailsPage(_serverController, recipe);
            case "/add_recipe":
              return AddRecipePage(_serverController, context);
            default:
              return LoginPage(_serverController, context);
          }
        });
      },
    );
  }
}
