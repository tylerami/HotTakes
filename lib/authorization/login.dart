import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/authorization/register.dart';
import 'package:hottakes1/services/auth.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();
  String error = '';
  final _formKey = GlobalKey<FormState>();

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
          body: Stack(children: <Widget>[
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
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Image.asset('assets/logohor.png'),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 30, 30, 10),
                              child: TextFormField(
                                validator: (val) => val.isEmpty
                                    ? "Email field is empty, try again"
                                    : null,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  icon: new Icon(Icons.security,
                                      color: Colors.white),
                                ),
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 30, 30, 10),
                              child: TextFormField(
                                validator: (val) => val.isEmpty
                                    ? "Password field is empty, try again"
                                    : null,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  icon: new Icon(Icons.security,
                                      color: Colors.white),
                                ),
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),
                            ),
                            FlatButton(
                                color: Colors.black.withOpacity(0.00),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result =
                                        await _auth.signIn(email, password);
                                    if (result == null) {
                                      setState(() => error =
                                          'Please enter a valid email and password ');
                                    }
                                  }
                                },
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
                                                      fontWeight:
                                                          FontWeight.w700))),
                                        ),
                                        Icon(Icons.arrow_forward_ios_sharp,
                                            color: Colors.white)
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                      Text(error,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400))),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: FlatButton(
                              color: Colors.black.withOpacity(0.00),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    CupertinoPageRoute<bool>(
                                        builder: (BuildContext context) =>
                                            Register()));
                              },
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
              ),
            )
          ]),
        ));
  }
}
