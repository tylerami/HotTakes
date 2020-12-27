import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:hottakes1/flutter_cupertino_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/auth.dart';
import 'package:hottakes1/services/controlpanel.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  String uid = '';
  bool _switch = true;
  CSWidgetStyle brightnessStyle = const CSWidgetStyle(
      icon: const Icon(Icons.brightness_medium, color: Colors.black54));

  @override
  void didChangeDependencies() {
    final user = Provider.of<MyUser>(context);
    uid = user != null ? user.uid : '';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
            backgroundColor: Color(0xff111111),
            middle: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Settings',
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
        child: uid != ''
            ? StreamProvider<UserData>.value(
                value: DatabaseService(uid: uid).userData,
                builder: (context, child) {
                  final userData = Provider.of<UserData>(context);
                  if (userData != null) {
                    _switch = userData.notifications;
                    return CupertinoSettings(
                      items: <Widget>[
                        CSHeader('PREMIUM'),
                        CSLink(
                          title: 'Upgrade your experience',
                          trailing: Icon(CupertinoIcons.chevron_right),
                        ),
                        CSHeader('SECURITY'),
                        CSLink(
                          title: 'Update password',
                          trailing: Icon(CupertinoIcons.chevron_right),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        PasswordForm(isEmailLink: false)));
                          },
                        ),
                        CSLink(
                          title: 'Change username',
                          trailing: Icon(CupertinoIcons.chevron_right),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => UsernameForm()));
                          },
                        ),
                        CSHeader('APP SETTINGS'),
                        CSControl(
                          contentWidget: CupertinoSwitch(
                              value: _switch,
                              activeColor: CupertinoColors.activeBlue,
                              onChanged: (bool value) {
                                setState(() => _switch = value);
                                DatabaseService().setNotifications(uid, value);
                              }),
                          nameWidget: Text('Notifications'),
                        ),
                        CSLink(
                            title: 'League preferences',
                            trailing: Icon(CupertinoIcons.chevron_right),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => Leagues()));
                            }),
                        CSLink(
                            title: 'Prize Delivery',
                            trailing: Icon(CupertinoIcons.chevron_right),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          DeliveryForm(prizeIndex: 0)));
                            }),
                        CSLink(
                            title: 'Logout',
                            trailing: Icon(CupertinoIcons.chevron_right),
                            onPressed: () async {
                              await _auth.signOut();
                              Navigator.of(context).pop();
                            }),
                        Container(
                            child: uid != ''
                                ? uid == 'ZFczk4pT3GMU6l8QzswZEC5DHTj2'
                                    ? CSLink(
                                        title: 'Admin Control',
                                        trailing:
                                            Icon(CupertinoIcons.chevron_right),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      ControlPanel()));
                                        },
                                      )
                                    : SizedBox()
                                : SizedBox())
                      ],
                    );
                  } else
                    return Container();
                })
            : Container());
  }
}

class Leagues extends StatefulWidget {
  @override
  _LeaguesState createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  int firstIndex;
  int secondIndex;

  int indexFromLeague(String league) {
    int i = 0;
    switch (league) {
      case 'NFL':
        i = 0;
        break;
      case 'NBA':
        i = 1;
        break;
      case 'NHL':
        i = 2;
        break;
      case 'MLB':
        i = 3;
        break;
      default:
        i = 1;
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        builder: (context, child) {
          final userData = Provider.of<UserData>(context) ?? null;
          if (userData != null) {
            firstIndex = indexFromLeague(userData.league1);
            secondIndex = indexFromLeague(userData.league2);
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    backgroundColor: Color(0xff111111),
                    middle: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('League Preferences',
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
                child: CupertinoSettings(items: <Widget>[
                  CSHeader('FIRST PREFERENCE'),
                  CSSelection<int>(
                    items: <CSSelectionItem<int>>[
                      CSSelectionItem<int>(text: 'NFL', value: 0),
                      CSSelectionItem<int>(text: 'NBA', value: 1),
                      CSSelectionItem<int>(text: 'NHL', value: 2),
                      CSSelectionItem<int>(text: 'MLB', value: 3)
                    ],
                    currentSelection: firstIndex,
                    onSelected: (index) {
                      firstIndex = index;
                      DatabaseService().setLeague1(userData.uid, index);
                    },
                  ),
                  CSHeader('SECOND PREFERENCE'),
                  CSSelection<int>(
                    items: <CSSelectionItem<int>>[
                      CSSelectionItem<int>(text: 'NFL', value: 0),
                      CSSelectionItem<int>(text: 'NBA', value: 1),
                      CSSelectionItem<int>(text: 'NHL', value: 2),
                      CSSelectionItem<int>(text: 'MLB', value: 3)
                    ],
                    currentSelection: secondIndex,
                    onSelected: (index) {
                      secondIndex = index;
                      DatabaseService().setLeague2(userData.uid, index);
                    },
                  )
                ]));
          } else
            return Container();
        });
  }
}

class DeliveryForm extends StatefulWidget {
  final int prizeIndex;
  DeliveryForm({this.prizeIndex});

  @override
  _DeliveryFormState createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm> {
  final _formKey = GlobalKey<FormState>();
  var _nameField = TextEditingController();
  var _cityField = TextEditingController();
  var _streetField = TextEditingController();
  var _unitField = TextEditingController();
  var _provinceField = TextEditingController();
  var _postalField = TextEditingController();

  bool init = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init = true;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final int prizeIndex = widget.prizeIndex;
    return StreamProvider<DocumentSnapshot>.value(
        value: DatabaseService(uid: user.uid).deliveryInfo,
        builder: (context, snapshot) {
          final doc = Provider.of<DocumentSnapshot>(context);
          if (doc != null) {
            if (init) {
              _nameField.text = doc.data()['name'];
              _cityField.text = doc.data()['city'];
              _streetField.text = doc.data()['address'];
              _unitField.text = doc.data()['unitnumber'];
              _provinceField.text = doc.data()['province'];
              _postalField.text = doc.data()['postalcode'];
              init = false;
            }
            return CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                    backgroundColor: Color(0xff111111),
                    middle: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Delivery Settings',
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
                        onTap: prizeIndex == 0
                            ? () {
                                Navigator.of(context).pop();
                              }
                            : () {
                                Navigator.of(context).pop();
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
                        SizedBox(height: 25),
                        Text('Verify and complete your prize delivery details.',
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
                                      width: 1.5, color: Colors.white70)),
                              color: Color(0xff1E1E1E)),
                          controller: _nameField,
                          keyboardType: TextInputType.name,
                          prefix: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(CupertinoIcons.person)),
                          placeholder: 'Name',
                          maxLines: 1,
                          maxLength: 20,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white38)),
                        CupertinoTextField(
                          decoration: BoxDecoration(color: Color(0xff1E1E1E)),
                          controller: _provinceField,
                          readOnly: true,
                          placeholder: 'Province',
                          placeholderStyle: TextStyle(
                              color: CupertinoColors.inactiveGray
                                  .withOpacity(0.6)),
                          onTap: () async {
                            _provinceField.text = await showCupertinoModalPopup(
                                useRootNavigator: false,
                                context: context,
                                builder: (BuildContext builder) {
                                  return CupertinoActionSheet(
                                      title: Text('Select Province'),
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () =>
                                            {Navigator.of(context).pop()},
                                        isDestructiveAction: true,
                                        child: Text('Cancel'),
                                      ),
                                      actions: [
                                        CupertinoActionSheetAction(
                                          child: Text('Alberta'),
                                          onPressed: () => {
                                            Navigator.of(context).pop('Alberta')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('British Columbia'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('British Columbia')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Manitoba'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('Manitoba')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('New Brunswick'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('New Brunswick')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Newfoundland'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('Newfoundland')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Nova Scotia'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('Nova Scotia')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Ontario'),
                                          onPressed: () => {
                                            Navigator.of(context).pop('Ontario')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Prince Edward Island'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('Prince Edward Island')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Quebec'),
                                          onPressed: () => {
                                            Navigator.of(context).pop('Quebec')
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Saskatchewan'),
                                          onPressed: () => {
                                            Navigator.of(context)
                                                .pop('Saskatchewan')
                                          },
                                        )
                                      ]);
                                });
                          },
                          keyboardType: TextInputType.text,
                          prefix: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(CupertinoIcons.flag)),
                          maxLines: 1,
                          maxLength: 20,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white38)),
                        CupertinoTextField(
                          decoration: BoxDecoration(color: Color(0xff1E1E1E)),
                          controller: _cityField,
                          keyboardType: TextInputType.text,
                          prefix: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(CupertinoIcons.building_2_fill)),
                          placeholder: 'City',
                          maxLines: 1,
                          maxLength: 15,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white38)),
                        CupertinoTextField(
                          decoration: BoxDecoration(color: Color(0xff1E1E1E)),
                          controller: _streetField,
                          keyboardType: TextInputType.streetAddress,
                          prefix: Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(CupertinoIcons.house)),
                          placeholder: 'Street Address',
                          maxLines: 1,
                          maxLength: 20,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white38)),
                        CupertinoTextField(
                          decoration: BoxDecoration(color: Color(0xff1E1E1E)),
                          controller: _unitField,
                          keyboardType: TextInputType.streetAddress,
                          prefix: Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(CupertinoIcons.house)),
                          placeholder: 'Unit number',
                          maxLines: 1,
                          maxLength: 20,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white38)),
                        CupertinoTextField(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white70, width: 1.5)),
                              color: Color(0xff1E1E1E)),
                          controller: _postalField,
                          keyboardType: TextInputType.streetAddress,
                          prefix: Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(CupertinoIcons.house)),
                          placeholder: 'Postal Code',
                          maxLines: 1,
                          maxLength: 7,
                          style: TextStyle(
                              fontFamily: 'SFProDisplay', fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        CupertinoButton(
                          onPressed: () {
                            if (_nameField.text.isEmpty ||
                                _provinceField.text.isEmpty ||
                                _cityField.text.isEmpty ||
                                _streetField.text.isEmpty ||
                                _postalField.text.isEmpty) {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Error'),
                                      content: Text(
                                          'Please fill out all required fields'),
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
                              // Validation passed
                              DatabaseService().updateDeliveryInfo(
                                  user.uid,
                                  _nameField.text,
                                  _provinceField.text,
                                  _cityField.text,
                                  _streetField.text,
                                  _unitField.text,
                                  _postalField.text);
                              DatabaseService().submitPrizeClaim(user.uid,
                                  Gamemanager().getDate(), prizeIndex);
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Success'),
                                      content: Text(prizeIndex == 0
                                          ? 'Delivery info updated successfull'
                                          : 'Your prize is on its way!'),
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
                            prizeIndex == 0 ? 'Submit' : 'Submit for Delivery',
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
