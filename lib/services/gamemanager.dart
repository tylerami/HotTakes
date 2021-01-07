class Gamemanager {
  String getGameID(int game) {
    final String year =
        DateTime.now().year.toString()[2] + DateTime.now().year.toString()[3];
    final String month = DateTime.now().month.toString().length == 2
        ? DateTime.now().month.toString()
        : '0' + DateTime.now().month.toString();
    final String day = DateTime.now().day.toString().length == 2
        ? DateTime.now().day.toString()
        : '0' + DateTime.now().day.toString();
    return year + ' ' + month + ' ' + day + ' G' + game.toString();
  }

  String getDate() {
    final String year =
        DateTime.now().year.toString()[2] + DateTime.now().year.toString()[3];
    final String month = DateTime.now().month.toString().length == 2
        ? DateTime.now().month.toString()
        : '0' + DateTime.now().month.toString();
    final String day = DateTime.now().day.toString().length == 2
        ? DateTime.now().day.toString()
        : '0' + DateTime.now().day.toString();
    return year + ' ' + month + ' ' + day;
  }
}

class Game {
  String gameID;
  String team1;
  String team2;
  String odds1;
  String odds2;
  String subtitle1;
  String subtitle2;
  int winner;
  String team1score;
  String team2score;
  String logoOverride;

  Game(
      {this.gameID,
      this.team1,
      this.team2,
      this.odds1,
      this.odds2,
      this.subtitle1,
      this.subtitle2,
      this.team1score,
      this.team2score,
      this.winner,
      this.logoOverride});
}

class GamePair {
  final Game game1;
  final Game game2;
  GamePair({this.game1, this.game2});
}
