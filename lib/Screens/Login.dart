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
  final _formKey= GlobalKey<FormState>();
  String email;
  String password;
  bool showSpinner=false;
  final _auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          // alignment: Alignment.center,
          children: [
            ModalProgressHUD(
              inAsyncCall: showSpinner,
                child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child:Container(
                      height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2000)),
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Login', style: TextStyle(fontSize: 20.0, color: Colors.black),),
                          Column(
                            children: [
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.red
                            ),
                            height: 50.0,
                            // color:Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.account_circle),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      color: Colors.white
                                    ),
                                    width: MediaQuery.of(context).size.width/2 *1.55,
                                    height: 40.0,
                                    // color: Colors.white,
                                    child:TextFormField(
                                        decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        contentPadding: EdgeInsets.all(5.0),
                                        hintText: 'Enter email'
                                      ),
                                      validator: (val) =>
                                      val.isEmpty 
                                          ? 'Enter a valid Email'
                                          : null,
                                        onChanged: (value){
                                          email=value;
                                        },
                            ), ),
                                )
                            ],)
                          ),
                          SizedBox(height:20.0),
                         Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.red
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.enhanced_encryption),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      color: Colors.white
                                    ),
                                    width: MediaQuery.of(context).size.width/2 *1.55,
                                    height: 40.0,
                                    child:TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none
                                        ),
                                        contentPadding: EdgeInsets.all(5.0),
                                         hintText: 'Enter Password'
                                    ),
                                    textAlign: TextAlign.justify,
                                    obscureText: true,
                                    validator:  (val) =>
                                      val.isEmpty || val.length < 6
                                          ? 'Enter a valid password'
                                          : null,
                                    onChanged: (value){
                                      password=value;
                                    },

                            ), ),
                                )
                            ],)
                          ),
                            ],
                          ),
                          MaterialButton(
                            height: 60,
                            shape:CircleBorder(side: BorderSide.none),
                            color: Colors.green[300],
                            child:  Icon(CupertinoIcons.forward,size: 30.0,),
                              onPressed: () async{
                                setState(() {
                                      showSpinner=true;
                                    });
                                try{
                                 if(_formKey.currentState.validate()){
                                   final newUser =await _auth.signInWithEmailAndPassword(email: email, password: password);
                                 if(newUser!=null){
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen()));
                                 }
                                 setState(() {
                                      showSpinner=false;
                                  });
                                 }
                               }catch(e){
                                 print(e);
                               }

                              }
                              ),
                      ],)
                    ) 
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

