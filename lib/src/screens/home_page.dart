import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

class HomePage extends StatefulWidget {
  final User loggedUser;

  const HomePage({Key? key, required this.loggedUser}):super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }
}