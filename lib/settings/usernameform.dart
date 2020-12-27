import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:provider/provider.dart';

class UsernameForm extends StatefulWidget {
  @override
  _UsernameFormState createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  final _formKey = GlobalKey<FormState>();
  var _usernameField = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        builder: (context, child) {
          final userData = Provider.of<UserData>(context);
          if (userData != null) {
            _usernameField.text = userData.username;
            return CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                    backgroundColor: Color(0xff111111),
                    middle: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Username Settings',
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
                        Text('Update your current username.',
                            style: TextStyle(
                                fontFamily: "SFProDisplay",
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        SizedBox(height: 15),
                        CupertinoTextField(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      width: 1, color: Colors.white70),
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white70)),
                              color: Color(0xff1E1E1E)),
                          controller: _usernameField,
                          keyboardType: TextInputType.text,
                          prefix: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(CupertinoIcons.person)),
                          maxLines: 1,
                          maxLength: 12,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        CupertinoButton(
                          onPressed: () async {
                            if (await DatabaseService()
                                    .isUsernameTaken(_usernameField.text) ==
                                false) {
                              DatabaseService().setUsername(
                                  userData.uid, _usernameField.text);
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title:
                                          Text('Username successfully updated'),
                                      content: SizedBox(height: 5),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok',
                                                style: TextStyle(
                                                    color: CupertinoColors
                                                        .activeBlue)))
                                      ],
                                    );
                                  });
                            } else {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Try Again'),
                                      content: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Text(
                                            'Username is not currently available.'),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok',
                                                style: TextStyle(
                                                    color: CupertinoColors
                                                        .activeBlue)))
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 20,
                                color: CupertinoColors.activeBlue),
                          ),
                        ),
                      ],
                    )));
          } else
            return Container();
        });
  }
}
