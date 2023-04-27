import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rewdee_app/screens/places.dart';

import '../models/profile.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final FormFieldSetter<String>? onSaved;

  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: 'admin@gmail.com', password: '123456');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  // _RegisterScreenState(this.onSaved);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(179, 255, 81, 69))),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Login to system"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("Login",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromRGBO(255, 252, 241, 0.702),
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 40,
                            ),
                            Text("Email",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xB3FCEED3))),
                            TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter your Email!"),
                                EmailValidator(
                                    errorText: "Email format is incorrect!")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) {
                                profile.email = newValue!;
                              },
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.702)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Password",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xB3FCEED3))),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Please enter your Password!"),
                              obscureText: true,
                              onSaved: (newValue) {
                                profile.password = newValue!;
                              },
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.702)),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text("Login",
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () async {
                                  // formKey.currentState?.save();
                                  // print("Email = ${profile.email}, Password = ${profile.password}");
                                  // formKey.currentState?.reset();
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    try {
                                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password).then((value){
                                        formKey.currentState?.reset();
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context){
                                            return const PlacesScreen();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.TOP);
                                    }
                                  }
                                },
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Log in"),),
  //   );
  // }
}
