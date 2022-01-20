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
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/register", arguments: serverController.loggedUser);
            },
          ),
          ListTile(
            title: const Text(
              "My recipes",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            leading: const Icon(
              Icons.book,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/my_recipes");
            },
          ),
          ListTile(
            title: const Text(
              "My favourites",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/favorites");
            },
          ),
          ListTile(
            title: const Text(
              "Log Out",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed("/");
            },
          )
        ],
      ),
    );
  }
}
