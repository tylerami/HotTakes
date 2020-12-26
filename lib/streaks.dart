import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hottakes1/fire_icon_icons.dart' as FireIcon;
import 'package:hottakes1/models/pick.dart';
import 'package:hottakes1/models/takecard.dart';
import 'package:hottakes1/models/takeslist.dart';
import 'package:hottakes1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user.dart';

class Streaks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Pick>>.value(
        value: DatabaseService(uid: user.uid).picks ?? [], child: TakesList());
  }
}
