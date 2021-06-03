import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipychat/Screens/ChatScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width / 2 * 1.55;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: Stack(
          children: [
            ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(2000),
                        ),
                        color: Color.fromRGBO(
                          255,
                          255,
                          255,
                          0.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.teal,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.indigo,
                                ),
                                height: 70.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          color: Colors.white,
                                        ),
                                        width: sizeWidth,
                                        height: 60.0,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: EdgeInsets.all(5.0),
                                            hintText: 'Enter Email',
                                          ),
                                          validator: (val) {
                                            return val.isEmpty
                                                ? 'Enter a valid Email'
                                                : null;
                                          },
                                          onChanged: (value) {
                                            email = value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 70.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.indigo,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          color: Colors.white,
                                        ),
                                        width: sizeWidth,
                                        height: 60.0,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: EdgeInsets.all(5.0),
                                            hintText: 'Enter Password',
                                          ),
                                          obscureText: true,
                                          validator: (val) {
                                            return val.isEmpty || val.length < 6
                                                ? 'Enter a valid password'
                                                : null;
                                          },
                                          onChanged: (value) {
                                            password = value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          MaterialButton(
                            height: 60,
                            shape: CircleBorder(
                              side: BorderSide.none,
                            ),
                            color: Colors.green[300],
                            child: Icon(
                              CupertinoIcons.forward,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              try {
                                if (_formKey.currentState.validate()) {
                                  final newUser =
                                      await _auth.signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  if (newUser != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
