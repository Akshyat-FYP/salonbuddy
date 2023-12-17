import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:han/home.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Barberboss",
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 195, 211, 200)),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('BarberBoss'),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('lib/assets/image1.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:5.0,right: 5.0,top:30,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                        labelText: 'E-mail',
                        hintText: 'Enter your email address'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.password_rounded,
                          color: Colors.black,
                        ),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    //validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Invalid First Name';
                    //       }
                    //       return null;
                    //     },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 30.0, bottom: 0),
                  child: Container(
                    height: 50,
                    width: 160,
                    decoration: BoxDecoration(
                        //color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => home()));
                        Get.snackbar(
                          "You've pressed on login",
                          "Let's get started",
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: Text("Welcome to barberboss"),
                          messageText: Text(
                            "Youve sucessfully landed in this page",
                            style: TextStyle(color: Colors.black),
                          ),
                          colorText: Colors.black,
                          borderRadius: 25,
                          margin: EdgeInsets.all(14.0),
                          animationDuration: Duration(milliseconds: 3000),
                          backgroundGradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                          ),
                          borderColor: Color.fromARGB(255, 188, 225, 188),
                          borderWidth: 4,
                          boxShadows: [
                            BoxShadow(
                                color: Color.fromARGB(255, 234, 233, 233),
                                offset: Offset(30, 50),
                                spreadRadius: 20,
                                blurRadius: 8)
                          ],
                          isDismissible: true,
                          forwardAnimationCurve: Curves.bounceInOut,
                          duration: Duration(milliseconds: 7000),
                          icon: Icon(Icons.message, color: Colors.black),
                          overlayBlur: 5,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 5.0, top: 30.0, bottom: 0),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 160,
                ),
                Text(
                  'New User? Create Account',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                ),
              ],
            ),
          ),
        ));
  }
}
