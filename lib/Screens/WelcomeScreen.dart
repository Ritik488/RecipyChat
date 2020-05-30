import 'package:flutter/material.dart';
import 'package:recipychat/Screens/Login.dart';
import 'package:recipychat/Screens/Signup.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'Logo',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  
                ),
                height: 100.0,
                width: 100.0,
                child: Image.network('https://designs.bobcares.com/wp-content/uploads/2018/01/Chat-room-presentation.png'),
              )
            ),
            SizedBox(height: 20.0,),
            Container(
              margin: EdgeInsets.all(15.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width/2,
              child: RaisedButton(
                color: Colors.red,
                child: Text('Login'),
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),)),
              ),
            ),

            Container(
              margin: EdgeInsets.all(15.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width/2,
              child: RaisedButton(
                color: Colors.green,
                child: Text('Signup'),
                onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen(),)),
              ),
            ),
          ],
        ),
      )
    );
  }
}
