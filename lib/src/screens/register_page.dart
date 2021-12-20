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

  RegisterPage(this.serverController, this.context, {Key? key}) : super(key: key);

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
                                    onPressed: () => _register(context),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text("Sign up")
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



  _register(BuildContext context) async {
    if(_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      if (imageFile.path == "") {
        showSnackBar(context, "Select an image please", Colors.orange);
        return;
      }

      User userr = User(nickname: userName,password: password,genrer: genrer,photo: imageFile);
      final state = await widget.serverController.addUser(userr);

      if(state) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Information"),
                content: const Text("Your user has been successfully registered"),
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
          showSnackBar(context, "Failed to register", Colors.orange);
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
}