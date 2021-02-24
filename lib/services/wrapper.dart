import 'package:flutter/cupertino.dart';
import 'package:hottakes1/authorization/login.dart';
import 'package:hottakes1/screens/dashboard.dart';
import 'package:hottakes1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:hottakes1/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);
    // return home or login
    if (user == null) {
      return Login();
    } else {
      /*  DatabaseService()
          .setGameToday(1, 'cow', 'jaz', 'T:224.5', '-4.5', '1-0', '0-1', '');
      DatabaseService()
          .setGameToday(2, 'rap', 'war', 'T:233.0', '-10.0', '0-1', '0-1', '');
      DatabaseService().givePick(user.uid);*/

      return Dashboard();
    }
  }
}
