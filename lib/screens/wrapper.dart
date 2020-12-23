import 'package:flutter/cupertino.dart';
import 'package:hottakes1/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:hottakes1/models/user.dart';
import 'package:hottakes1/screens/authenticate/authenticate.dart';
import 'package:hottakes1/login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);
    // return home or login
    if (user == null) {
      return Login();
    } else {
      return Dashboard();
    }
  }
}
