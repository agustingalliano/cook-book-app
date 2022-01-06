import 'dart:io';

import 'package:cook_book/src/components/image_picker_widget.dart';
import 'package:cook_book/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/models.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  ServerController serverController;
  BuildContext context;
  User userToEdit;

  RegisterPage(this.serverController, this.context, this.userToEdit, {Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _loading = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String userName = "";
  String password = "";
  Genrer genrer = Genrer.MALE;
  bool showPassword = false;
  bool editingUser = false;

  File imageFile = File("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formkey,
          child: Stack(
            children: <Widget>[
              ImagePickerWidget(
                imageFile: imageFile,
                onImageSelected: (XFile file) {
                  setState(() {
                    imageFile = File(file.path);
                  });
                },
              ),
              SizedBox(
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                height: kToolbarHeight + 25,
              ),
              Center(
                child: Transform.translate(
                offset: const Offset(0, -40),
                      child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 260, bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 20),
                            child: ListView(
                              children: [
                                TextFormField(
                                  initialValue: userName,
                                  decoration:
                                  const InputDecoration(labelText: "User: "),
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  validator: (value) {
                                    if(value!=null){
                                      if(value.isEmpty){
                                        return "This field is required";
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  initialValue: password,
                                  decoration:
                                  InputDecoration(
                                      labelText: "Password: ",
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              showPassword = !showPassword;
                                            });
                                          },
                                          icon: Icon(showPassword?Icons.visibility:Icons.visibility_off),
                                      ),
                                  ),
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  validator: (value) {
                                    if(value!=null){
                                      if(value.isEmpty){
                                        return "This field is required";
                                      }
                                    }
                                  },
                                  obscureText: !showPassword,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(children: [
                                  Text(
                                    "Gender",
                                    style:
                                    TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        RadioListTile(
                                          title: const Text("Male"),
                                          value: Genrer.MALE,
                                          groupValue: genrer,
                                          onChanged: (Genrer? value) {
                                            setState(() {
                                              genrer = value!;
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                          title: const Text("Female"),
                                          value: Genrer.FEMALE,
                                          groupValue: genrer,
                                          onChanged: (Genrer? value) {
                                            setState(() {
                                              genrer = value!;
                                            });
                                          },
                                        )
                                      ],
                                    )
                                  )
                                ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () => _doProcess(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            (editingUser) ? "Update" : "Sign up")
                                      ],
                                    )
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          )),
              ),)
            ],
          ),
        )
    );
  }



  _doProcess(BuildContext context) async {
    if(_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      if (imageFile.path == "") {
        showSnackBar(context, "Select an image please", Colors.orange);
        return;
      }

      User user = User(nickname: userName,password: password,genrer: genrer,photo: imageFile);
      bool state;

      if(editingUser) {
        user.id = widget.serverController.loggedUser.id;
        state = await widget.serverController.updateUser(user);
      } else {
        state = await widget.serverController.addUser(user);
      }
      final action = editingUser ? "updated" : "registered";
      final action2 = editingUser ? "update" : "register";
      if(state) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Information"),
                content: Text("User has been successfully $action"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"),
                  )
                ],
              );
            }
          );
        } else {
          showSnackBar(context, "Failed to $action2", Colors.orange);
        }
    }
  }

  void showSnackBar (BuildContext context, String title, Color backColor) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: backColor,
        ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editingUser = widget.userToEdit != null;

    if(editingUser) {
      userName = widget.userToEdit.nickname;
      password = widget.userToEdit.password;
      imageFile = widget.userToEdit.photo;
      genrer = widget.userToEdit.genrer;
    }
  }

  void _update(BuildContext context) {}

}