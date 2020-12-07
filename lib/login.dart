import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/main.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  CupertinoTextField usernameField = CupertinoTextField(
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(fontSize: 18, color: Colors.white)),
      placeholder: "Email or username",
      suffix: new Icon(Icons.security, color: Colors.white),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ));

  CupertinoTextField passwordField = CupertinoTextField(
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(fontSize: 18, color: Colors.white)),
      placeholder: "Password",
      obscureText: true,
      suffix: new Icon(Icons.security, color: Colors.white),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white)),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: CupertinoPageScaffold(
          child: Stack(children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromARGB(255, 21, 0, 0),
                      Color.fromARGB(255, 60, 0, 0)
                    ]))),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Image.asset('assets/logohor.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                      child: usernameField,
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                        child: passwordField),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FlatButton(
                          color: Colors.black.withOpacity(0.00),
                          onPressed: null,
                          child: Container(
                              height: 58,
                              width: 260,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Color.fromARGB(255, 255, 107, 14),
                                    Color.fromARGB(255, 216, 68, 0)
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        100, 0, 70, 0),
                                    child: Text('Login',
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700))),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.white)
                                ],
                              ))),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: FlatButton(
                            color: Colors.black.withOpacity(0.00),
                            onPressed: null,
                            child: Container(
                                height: 58,
                                width: 260,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Color.fromARGB(150, 0, 0, 0),
                                      Color.fromARGB(255, 0, 0, 0)
                                    ],
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          55, 0, 25, 0),
                                      child: Text('Create Account',
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ),
                                    Icon(Icons.arrow_forward_ios_sharp,
                                        color: Colors.white)
                                  ],
                                )))),
                    TextButton(
                        onPressed: null,
                        child: Text("Forgot Password?",
                            style: GoogleFonts.montserrat(
                                color: Colors.grey[300],
                                fontSize: 14,
                                fontWeight: FontWeight.w400)))
                  ]),
            )
          ]),
        ));
  }
}
