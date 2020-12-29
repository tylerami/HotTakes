class Pick {
  int year;
  int month;
  int day;
  String gameID;
  int team;
  Pick({this.year, this.month, this.day, this.gameID, this.team});
}

class FriendPick {
  int year;
  int month;
  int day;
  String gameID;
  int team;
  String username;
  FriendPick(
      {this.username, this.year, this.month, this.day, this.gameID, this.team});
}
