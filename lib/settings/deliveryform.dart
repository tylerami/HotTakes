import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:provider/provider.dart';

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
                              DatabaseService().setStreakResetDate(
                                  user.uid, Gamemanager().getDate());
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
