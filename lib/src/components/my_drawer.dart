import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  ServerController serverController;

  MyDrawer({Key? key, required this.serverController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text(
              serverController.loggedUser.nickname,
              style: const TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: FileImage(serverController.loggedUser.photo),
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://antonioleiva.com/wp-content/uploads/2014/10/WallpaperAndroid50.jpg",
                    ),
                    fit: BoxFit.cover)),
            onDetailsPressed: () {

            },
          )
        ],
      ),
    );
  }
}
