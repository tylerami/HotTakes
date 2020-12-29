import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hottakes1/models/friendtile.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/services/database.dart';
import 'package:hottakes1/services/gamemanager.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  FriendTile result;
  var _searchController = TextEditingController(text: '');

  Future<void> updateSearch(String val) async {
    final streak = await DatabaseService().streakFromUsername(val);
    if (await DatabaseService().isUsernameTaken(val)) {
      setState(() {
        result = FriendTile(username: val, areFriends: false, streak: streak);
      });
    } else {
      result = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return StreamProvider<List<Game>>.value(
        value: DatabaseService().games,
        builder: (context, child) {
          final games = Provider.of<List<Game>>(context);
          if (games == null)
            return Container();
          else {
            return StreamProvider<List<String>>.value(
                value: DatabaseService(uid: user.uid).friends,
                builder: (context, child) {
                  final friends = Provider.of<List<String>>(context);
                  if (friends == null) return Container();
                  return Localizations(
                      locale: const Locale('en', ''),
                      delegates: <LocalizationsDelegate<dynamic>>[
                        DefaultWidgetsLocalizations.delegate,
                        DefaultMaterialLocalizations.delegate,
                      ],
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    textBaseline: TextBaseline.alphabetic),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.0)),
                                      borderSide:
                                          BorderSide(color: Colors.white30)),
                                  labelText: null,
                                  alignLabelWithHint: false,
                                  hintText: "Search...",
                                  hintStyle: TextStyle(
                                      height: 1.0,
                                      textBaseline: TextBaseline.alphabetic,
                                      color: Colors.white),
                                  prefixIcon: Icon(CupertinoIcons.search,
                                      color: Colors.white70),
                                  fillColor: Color(0xff1c1c1c),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      bottom: 2, left: 2, right: 2),
                                ),
                                controller: _searchController,
                                onChanged: (val) async {
                                  await updateSearch(val);
                                },
                              ),
                              result ?? Container(),
                              SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: friends.length,
                                    itemBuilder: (context, index) {
                                      return FutureProvider<String>.value(
                                          value: DatabaseService()
                                              .streakFromUsername(
                                                  friends[index]),
                                          builder: (context, child) {
                                            final streak =
                                                Provider.of<String>(context);
                                            if (streak == null)
                                              return Container();
                                            else {
                                              return Center(
                                                child: FriendTile(
                                                    username: friends[index],
                                                    areFriends: true,
                                                    streak: streak),
                                              );
                                            }
                                          });
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ));
                });
          }
        });
  }
}
