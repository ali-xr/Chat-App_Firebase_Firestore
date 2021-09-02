// ignore_for_file: avoid_print, file_names, prefer_final_fields, prefer_const_constructors, unnecessary_null_comparison
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  var _formKey1 = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  FirebaseAuth _authUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return  Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
            color: Colors.white),
        child: Form(
          key: _formKey1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 20),
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
                  style: TextStyle(color: Colors.black),
                  controller: email,
                  validator: (String? text) {
                    if (text!.length < 6) {
                      return "Email 6 ta belgidan kam bolmasin !";
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    hoverColor: Colors.black,
                    hintText: "Email Id or phone number",
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
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
                  style: TextStyle(color: Colors.black),
                  controller: password,
                  validator: (String? text) {
                    if (text!.length < 6) {
                      return "Password 6 ta belgidan kam bolmasin !";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon:
                        Icon(Icons.visibility_off_outlined, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 2),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 30, top: 15, bottom: 20),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    if (_formKey1.currentState!.validate()) {
                      final user = await _authUser.signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      if (user != null) {
                        Navigator.pushReplacementNamed(context, '/chatui');
                      }
                    }
                  } catch (e) {
                    // SNACKBAR KERAK
                    print("LOGINDA XATO BOR: " + e.toString());
                  }
                },
                child: Container(
                  height: 60.0,
                  width: 170.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFFFF9900)),
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  height: 50.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      "Gmail",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: _googleSignIn,
              ),
            ],
          ),
        ),
      
    );
  }

  _googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
