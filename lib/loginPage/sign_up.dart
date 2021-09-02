// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:chat/loginPage/singIn.dart';
import 'package:chat/ui/chatui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SingInUp extends StatefulWidget {
  const SingInUp({Key? key}) : super(key: key);

  @override
  _SingInUpState createState() => _SingInUpState();
}

FirebaseAuth _authUser = FirebaseAuth.instance;

class _SingInUpState extends State<SingInUp> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController passwordCheck = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFCF4F4),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          dragStartBehavior: DragStartBehavior.down,
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: Color(0xFFFCF4F4),
                floating: true,
                stretch: true,
                toolbarHeight: height / 4,
                title: Container(
                  height: height,
                  child: Image.asset("assets/images/amazon.png"),
                ),
                // collapsedHeight: 100.0,
                bottom: TabBar(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  labelColor: Color(0xFFFF9900),
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Color(0xFFFF9900),
                  labelStyle: TextStyle(fontSize: 30.0),
                  tabs: [
                    Tab(
                      text: "Login",
                    ),
                    Tab(
                      text: "Sing-up",
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            SingIn(),
            singUp(),
          ]),
        ),
      ),
    );
  }

  Widget singUp() {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white),
      child: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.blueAccent),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: "Full name",
                          hintStyle: TextStyle(color: Colors.grey)),
                      controller: name,
                      validator: (text) {
                        if (text!.length < 3) {
                          return "You need at least 3 characters";
                        }
                      },
                    ),
                  ),
                  // Email
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.blueAccent),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey)),
                      controller: email,
                      validator: (text) {
                        if (text!.length < 4) {
                          return "You need at least 4 characters";
                        }
                      },
                    ),
                  ),
                  // Phone
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.blueAccent),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: "Phone",
                          hintStyle: TextStyle(color: Colors.grey)),
                      controller: phone,
                      validator: (text) {
                        if (text!.length < 9) {
                          return "You need at least 9 characters";
                        }
                      },
                    ),
                  ),
                  // Password
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.blueAccent),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey)),
                      obscureText: true,
                      controller: password,
                      validator: (text) {
                        if (text!.length < 6) {
                          return "You need at least 6 characters";
                        }
                      },
                    ),
                  ),
                  //Confirm Password
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          color: Colors.grey.withOpacity(1),
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.blueAccent),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      obscureText: true,
                      controller: passwordCheck,
                      validator: (text) {
                        if (text!.length < 6) {
                          return "You need at least 6 characters";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                alignment: Alignment.center,
                height: 50.0,
                width: 160.0,
                child: Text(
                  "CREATE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              onTap: _emailSignUp,
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Already have an accaunt?",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  InkWell(
                    child: Text(
                      "Login here",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingInUp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _emailSignUp() async {
    try {
      if (_formKey.currentState!.validate()) {
        await _authUser.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        if (_authUser.currentUser != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatUi()));
        }
      }
    } catch (e) {
      print("HAAA XATO BOR NIMA GAAAP !: $e");
    }
  }
}
