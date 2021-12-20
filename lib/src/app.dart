import 'package:cook_book/src/connection/server_controller.dart';
import 'package:cook_book/src/screens/home_page.dart';
import 'package:cook_book/src/screens/login_page.dart';
import 'package:cook_book/src/screens/register_page.dart';
import 'package:flutter/material.dart';
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
              return HomePage(
                loggedUser: userLogged,
              );
            case "/register":
              return RegisterPage(_serverController, context);
            default:
              return LoginPage(_serverController, context);
          }
        });
      },
    );
  }
}
