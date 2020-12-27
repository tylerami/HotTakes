import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PasswordForm extends StatefulWidget {
  PasswordForm({this.isEmailLink});
  final bool isEmailLink;
  @override
  _PasswordFormState createState() =>
      _PasswordFormState(isEmailLink: isEmailLink);
}

class _PasswordFormState extends State<PasswordForm> {
  _PasswordFormState({this.isEmailLink});
  final bool isEmailLink;
  final _formKey = GlobalKey<FormState>();
  var _oldPassField = TextEditingController();
  var _newPassField1 = TextEditingController();
  var _newPassField2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Color(0xff111111),
            middle: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Password Settings',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    SizedBox(width: 50),
                  ],
                )),
            leading: Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff2F2F2F)),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white.withOpacity(.6), size: 25)),
              ),
            )),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Text('Update your current password.',
                    style: TextStyle(
                        fontFamily: "SFProDisplay",
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: 15),
                !this.isEmailLink
                    ? CupertinoTextField(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.5, color: Colors.white70)),
                            color: Color(0xff1E1E1E)),
                        controller: _oldPassField,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(CupertinoIcons.lock)),
                        placeholder: 'Old Password',
                        maxLines: 1,
                        maxLength: 12,
                        style:
                            TextStyle(fontFamily: 'SFProDisplay', fontSize: 20),
                      )
                    : SizedBox(height: 1),
                Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white38)),
                CupertinoTextField(
                  decoration: BoxDecoration(color: Color(0xff1E1E1E)),
                  obscureText: true,
                  controller: _newPassField1,
                  keyboardType: TextInputType.text,
                  prefix: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(CupertinoIcons.lock)),
                  placeholder: 'New Password',
                  maxLines: 1,
                  maxLength: 15,
                  style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 20),
                ),
                Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white38)),
                CupertinoTextField(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1.5, color: Colors.white70)),
                      color: Color(0xff1E1E1E)),
                  controller: _newPassField2,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  prefix: Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(CupertinoIcons.lock)),
                  placeholder: 'Confirm New Password',
                  maxLines: 1,
                  maxLength: 20,
                  style: TextStyle(fontFamily: 'SFProDisplay', fontSize: 20),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  onPressed: () {
                    if (_newPassField1.text != _newPassField2.text) {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('Error'),
                              content: Text('Passwords do not match'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Ok',
                                        style: TextStyle(
                                            color: CupertinoColors.activeBlue)))
                              ],
                            );
                          });
                    } else {
                      // Validation passed
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 20, color: CupertinoColors.activeBlue),
                  ),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Email sent'),
                            content: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                  'A password reset email link has been \nsent to t*****au@gmail.com'),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok',
                                      style: TextStyle(
                                          color: CupertinoColors.activeBlue)))
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Forgot old password?',
                    style: TextStyle(
                        fontSize: 20, color: CupertinoColors.activeBlue),
                  ),
                ),
              ],
            )));
  }
}
