import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/auth.dart';
import 'package:hottakes1/services/database.dart';

class Register extends StatefulWidget {
  Register({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscure = true;
  IconData eyecon = CupertinoIcons.eye_slash;
  String email = '';
  String username = '';
  String password = '';
  String error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool press = false;

  @override
  Widget build(BuildContext context) {
    return Localizations(
        locale: const Locale('en', 'US'),
        delegates: <LocalizationsDelegate<dynamic>>[
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        child: Scaffold(
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
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 120, 0, 20),
                            child: Image.asset('assets/logohor.png'),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 30, 10),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? "Email field is empty, try again"
                                        : null,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    decoration: InputDecoration(
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: CupertinoColors
                                                  .destructiveRed)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: CupertinoColors
                                                  .destructiveRed
                                                  .withOpacity(0.8))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color:
                                                  CupertinoColors.activeOrange,
                                              width: 2)),
                                      hintText: "Email",
                                      hintStyle: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70)),
                                      prefixIcon: new Icon(Icons.security,
                                          color: Colors.white),
                                    ),
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 30, 10),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? "Username field is empty, try again"
                                        : null,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    decoration: InputDecoration(
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: CupertinoColors
                                                  .destructiveRed)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: CupertinoColors
                                                  .destructiveRed
                                                  .withOpacity(0.8))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white70)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color:
                                                  CupertinoColors.activeOrange,
                                              width: 2)),
                                      hintText: "Username",
                                      hintStyle: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70)),
                                      prefixIcon: new Icon(Icons.person,
                                          color: Colors.white),
                                    ),
                                    onChanged: (val) {
                                      setState(() => username = val);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 30, 10),
                                  child: TextFormField(
                                    validator: (val) => val.isEmpty
                                        ? "Password field is empty, try again"
                                        : null,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: CupertinoColors
                                                    .destructiveRed)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: CupertinoColors
                                                    .destructiveRed
                                                    .withOpacity(0.8))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.white70)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: CupertinoColors
                                                    .activeOrange,
                                                width: 2)),
                                        hintText: "Password",
                                        hintStyle:
                                            GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 18, color: Colors.white70)),
                                        prefixIcon: new Icon(Icons.security, color: Colors.white),
                                        suffixIcon: IconButton(
                                          icon: Icon(eyecon,
                                              color: Colors.white70),
                                          onPressed: () {
                                            setState(() {
                                              obscure
                                                  ? obscure = false
                                                  : obscure = true;
                                              obscure
                                                  ? eyecon =
                                                      CupertinoIcons.eye_slash
                                                  : eyecon = CupertinoIcons.eye;
                                            });
                                          },
                                        )),
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: FlatButton(
                                      color: Colors.black.withOpacity(0.00),
                                      onPressed: () async {
                                        setState(() {
                                          press = true;
                                        });
                                        if (await DatabaseService()
                                            .isUsernameTaken(username)) {
                                          setState(() {
                                            error = 'Username is taken';
                                            press = false;
                                          });
                                        } else if (_formKey.currentState
                                            .validate()) {
                                          dynamic result = await _auth.register(
                                              email, password, username);
                                          if (result == null) {
                                            setState(() => error =
                                                'Please enter a valid email and password');
                                          } else {
                                            Navigator.of(context).pop();
                                          }
                                        } else {
                                          setState(() {
                                            press = false;
                                          });
                                        }
                                      },
                                      child: Container(
                                          height: 58,
                                          width: 260,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              press
                                                  ? BoxShadow(
                                                      color: CupertinoColors
                                                          .activeOrange,
                                                      spreadRadius: 2,
                                                      blurRadius: 10)
                                                  : BoxShadow(
                                                      color: Colors.red[500]
                                                          .withOpacity(.80),
                                                      blurRadius: 10)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                Color.fromARGB(
                                                    255, 255, 107, 14),
                                                Color.fromARGB(255, 216, 68, 0)
                                              ],
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        90, 0, 50, 0),
                                                child: Text('Register',
                                                    style: GoogleFonts.montserrat(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))),
                                              ),
                                              Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  color: Colors.white)
                                            ],
                                          ))),
                                ),
                              ],
                            ),
                          ),
                          Text(error,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: FlatButton(
                                  color: Colors.black.withOpacity(0.00),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                      height: 58,
                                      width: 260,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.60),
                                              blurRadius: 10)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios_sharp,
                                              color: Colors.white),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                60, 0, 80, 0),
                                            child: Text("Login",
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700))),
                                          )
                                        ],
                                      ))))
                        ]),
                  ),
                )
              ]),
            )));
  }
}
