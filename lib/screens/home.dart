import 'package:flutter/material.dart';
import 'package:rewdee_app/screens/register.dart';
import 'package:rewdee_app/screens/login.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/pin.png"),
              // Text("PinDee"),
              SizedBox(
                width: double.infinity,
                child: 
              ElevatedButton.icon(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                      return RegisterScreen();
                    })
                  );
                }, 
                icon: Icon(Icons.add), 
                label: Text("Create an account", style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: 
              ElevatedButton.icon(
                icon: Icon(Icons.login), 
                label: Text("Login to the system", style: TextStyle(fontSize: 20)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return LoginScreen();
                    })
                  );
                }, 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

          
        