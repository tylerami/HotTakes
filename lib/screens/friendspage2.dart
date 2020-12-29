import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/services/database.dart';

/*class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        width: 800,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffffe2cf),
            boxShadow: [BoxShadow(blurRadius: 5)]),
        child: Column(
          children: [
            Row(children: [
              Text(widget.username,
                  style: GoogleFonts.oswald(
                      color: Colors.white.withOpacity(.95),
                      fontWeight: FontWeight.w700,
                      fontSize: 24)),
              widget.areFriends == false
                  ? FlatButton(
                      onPressed: () {
                        DatabaseService().addFriend(user.uid, widget.username);
                      },
                      child: Text('Add Friend',
                          style: GoogleFonts.roboto(
                              color: CupertinoColors.activeBlue, fontSize: 12)))
                  : FlatButton(
                      onPressed: () {
                        DatabaseService()
                            .removeFriend(user.uid, widget.username);
                      },
                      child: Text('Remove Friend',
                          style: GoogleFonts.roboto(
                              color: CupertinoColors.destructiveRed,
                              fontSize: 12))),
            ]),
            Text('Current Streak: ' + widget.streak,
                style: GoogleFonts.roboto(
                    color: Colors.black.withOpacity(.85),
                    fontWeight: FontWeight.w700,
                    fontSize: 12)),
            Text('Last Pick:',
                style: GoogleFonts.roboto(
                    color: Colors.black.withOpacity(.85),
                    fontWeight: FontWeight.w700,
                    fontSize: 12)),
            Row(children: [
              Text(
                pickedRight == 0
                    ? Teams().teamFromInitials(pickedTeam) +
                        ' over ' +
                        Teams().teamFromInitials(opponentTeam)
                    : Teams().teamFromInitials(pickedTeam) +
                        ' (' +
                        pickedScore +
                        ') over ' +
                        Teams().teamFromInitials(
                            opponentTeam + ' (' + opponentScore + ')'),
                style: GoogleFonts.oswald(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                  width: 30,
                  child: pickedRight != 0
                      ? pickedRight == 1
                          ? Icon(CupertinoIcons.check_mark,
                              size: 25, color: Colors.green)
                          : Icon(CupertinoIcons.xmark,
                              size: 25, color: Colors.red)
                      : Container())
            ])
          ],
        ));
  }
}





Ink(
                  decoration: BoxDecoration(
                    color: Color(0xffdb5d09),
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(10)),
                  ),
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(300))),
                      title: Text(widget.username,
                          style: GoogleFonts.oswald(
                              color: Colors.white.withOpacity(.95),
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                      trailing: SizedBox(
                        width: 150,
                        child: widget.areFriends == false
                            ? FlatButton(
                                onPressed: () {
                                  DatabaseService()
                                      .addFriend(user.uid, widget.username);
                                },
                                child: Text('Add Friend',
                                    style: GoogleFonts.roboto(
                                        color: CupertinoColors.activeBlue,
                                        fontSize: 12)))
                            : FlatButton(
                                onPressed: () {
                                  DatabaseService()
                                      .removeFriend(user.uid, widget.username);
                                },
                                child: Text('Remove Friend',
                                    style: GoogleFonts.roboto(
                                        color: CupertinoColors.destructiveRed,
                                        fontSize: 12))),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Streak: ' + widget.streak,
                                style: GoogleFonts.roboto(
                                    color: Colors.white.withOpacity(.85),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)),
                            Text('Last Pick:',
                                style: GoogleFonts.roboto(
                                    color: Colors.white.withOpacity(.85),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)),
                            ListTile(
                                contentPadding: EdgeInsets.only(left: 50),
                                subtitle: Text(date,
                                    style: GoogleFonts.roboto(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                                title: Text(
                                  pickedRight == 0
                                      ? Teams().teamFromInitials(pickedTeam) +
                                          ' over ' +
                                          Teams().teamFromInitials(opponentTeam)
                                      : Teams().teamFromInitials(pickedTeam) +
                                          ' (' +
                                          pickedScore +
                                          ') over ' +
                                          Teams().teamFromInitials(
                                              opponentTeam +
                                                  ' (' +
                                                  opponentScore +
                                                  ')'),
                                  style: GoogleFonts.oswald(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: SizedBox(
                                    width: 30,
                                    child: pickedRight != 0
                                        ? pickedRight == 1
                                            ? Icon(CupertinoIcons.check_mark,
                                                size: 25, color: Colors.green)
                                            : Icon(CupertinoIcons.xmark,
                                                size: 25, color: Colors.red)
                                        : Container()))
                          ])));*/
