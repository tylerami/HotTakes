class Teams {
  String logoFromInitials(String initials) {
    if (initials == '') return '';
    return 'assets/nba/' + initials + ".png";
  }

  String uncapitalizedTeamFromInitials(String initials) {
    switch (initials) {
      case 'haw':
        return 'Hawks';
        break;
      case 'cel':
        return 'Celtics';
        break;
      case 'net':
        return 'Nets';
        break;
      case 'hor':
        return "Hornets";
        break;
      case 'bul':
        return 'Bulls';
        break;
      case 'cav':
        return 'Cavaliers';
        break;
      case 'mav':
        return "Mavericks";
        break;
      case 'nug':
        return 'Nuggets';
        break;
      case 'pis':
        return 'Pistons';
        break;
      case 'war':
        return "Warriors";
        break;
      case 'hroc':
        return 'Rockets';
        break;
      case 'pace':
        return 'Pacers';
        break;
      case 'cli':
        return "Clippers";
        break;
      case 'lak':
        return 'Lakers';
        break;
      case 'gri':
        return 'Grizzlies';
        break;
      case 'hea':
        return "Heat";
        break;
      case 'buck':
        return 'Bucks';
        break;
      case 'tim':
        return 'Timberwolves';
        break;
      case 'pel':
        return "Pelicans";
        break;
      case 'kni':
        return 'Knicks';
        break;
      case 'thu':
        return 'Thunder';
        break;
      case 'mag':
        return "Magic";
        break;
      case '76e':
        return '76ers';
        break;
      case 'sun':
        return 'Suns';
        break;
      case 'tra':
        return "Trail Blazers";
        break;
      case 'skin':
        return 'Kings';
        break;
      case 'spu':
        return "Spurs";
        break;
      case 'rap':
        return 'Raptors';
        break;
      case 'jaz':
        return 'Jazz';
        break;
      case 'wiz':
        return "Wizards";
        break;
      // NFL
      case 'car':
        return 'Cardinals';
        break;
      case 'fal':
        return 'Falcons';
        break;
      case 'rav':
        return "Ravens";
        break;
      case 'bil':
        return 'Bills';
        break;
      case 'cpan':
        return 'Panthers';
        break;
      case 'bea':
        return "Bears";
        break;
      case 'ben':
        return 'Bengals';
        break;
      case 'brow':
        return 'Browns';
        break;
      case 'cow':
        return "Cowboys";
        break;
      case 'bron':
        return 'Broncos';
        break;
      case 'lio':
        return 'Lions';
        break;
      case 'pack':
        return 'Packers';
        break;
      case 'tex':
        return 'Texans';
        break;
      case 'col':
        return 'Colts';
        break;
      case 'jag':
        return 'Jaguars';
        break;
      case 'chi':
        return 'Chiefs';
        break;
      case 'cha':
        return 'Chargers';
        break;
      case 'ram':
        return 'Rams';
        break;
      case 'dol':
        return 'Dolphins';
        break;
      case 'vik':
        return 'Vikings';
        break;
      case 'pat':
        return 'Patriots';
        break;
      case 'sai':
        return 'Saints';
        break;
      case 'ngia':
        return 'Giants';
        break;
      case 'njet':
        return 'Jets';
        break;
      case 'rai':
        return 'Raiders';
        break;
      case 'eag':
        return 'Eagles';
        break;
      case 'ste':
        return 'Steelers';
        break;
      case '49e':
        return '49ers';
        break;
      case 'sea':
        return 'Seahawks';
        break;
      case 'bucc':
        return 'Buccaneers';
        break;
      case 'tit':
        return 'Titans';
        break;
      case 'foo':
        return 'Football Team';
        break;
      //NHL
      case 'duc':
        return 'Ducks';
        break;
      case 'coy':
        return 'Coyotes';
        break;
      case 'bru':
        return 'Bruins';
        break;
      case 'sab':
        return 'Sabers';
        break;
      case 'fla':
        return 'Flames';
        break;
      case 'hur':
        return 'Hurricanes';
        break;
      case 'bla':
        return 'Blackhawks';
        break;
      case 'ava':
        return 'Avalanche';
        break;
      case 'bluj':
        return 'Blue Jackets';
        break;
      case 'sta':
        return 'Stars';
        break;
      case 'rdwi':
        return 'Red Wings';
        break;
      case 'oil':
        return 'Oilers';
        break;
      case 'fpan':
        return 'Panthers';
        break;
      case 'lkin':
        return 'Kings';
        break;
      case 'wil':
        return 'Wild';
        break;
      case 'cana':
        return 'Canadiens';
        break;
      case 'pre':
        return 'Predators';
        break;
      case 'dev':
        return 'Devils';
        break;
      case 'isl':
        return 'Islanders';
        break;
      case 'nran':
        return 'Rangers';
        break;
      case 'sen':
        return 'Senators';
        break;
      case 'fly':
        return 'Flyers';
        break;
      case 'pen':
        return 'Penguins';
        break;
      case 'sha':
        return 'Sharks';
        break;
      case 'blue':
        return 'Blues';
        break;
      case 'lig':
        return 'Lighting';
        break;
      case 'lea':
        return 'Maple Leafs';
        break;
      case 'canu':
        return 'Canucks';
        break;
      case 'gol':
        return 'Golden Knights';
        break;
      case 'cap':
        return 'Capitals';
        break;
      case 'wjet':
        return 'Jets';
        break;
      //MLB
      case 'dia':
        return 'Diamondbacks';
        break;
      case 'bra':
        return 'Braves';
        break;
      case 'ori':
        return 'Orioles';
        break;
      case 'rdso':
        return 'Red Sox';
        break;
      case 'whi':
        return 'White Sox';
        break;
      case 'cub':
        return 'Cubs';
        break;
      case 'red':
        return 'Reds';
        break;
      case 'ind':
        return 'Indians';
        break;
      case 'croc':
        return 'Rockies';
        break;
      case 'tig':
        return 'Tigers';
        break;
      case 'ast':
        return 'Astros';
        break;
      case 'roy':
        return 'Royals';
        break;
      case 'ang':
        return 'Angels';
        break;
      case 'dod':
        return 'Dodgers';
        break;
      case 'mmar':
        return 'Marlins';
        break;
      case 'bre':
        return 'Brewers';
        break;
      case 'twi':
        return 'Twins';
        break;
      case 'yan':
        return 'Yankees';
        break;
      case 'met':
        return 'Mets';
        break;
      case 'ath':
        return 'Athletics';
        break;
      case 'phi':
        return 'Phillies';
        break;
      case 'pir':
        return 'Pirates';
        break;
      case 'pad':
        return 'Padres';
        break;
      case 'sgia':
        return 'Giants';
        break;
      case 'smar':
        return 'Mariners';
        break;
      case 'scar':
        return 'Cardinals';
        break;
      case 'ray':
        return 'Rays';
        break;
      case 'tran':
        return 'Rangers';
        break;
      case 'blja':
        return 'Blue Jays';
        break;
      case 'nat':
        return 'Nationals';
        break;
      default:
        return initials;
        break;
    }
  }

  String uncapitalizedCityFromInitials(String initials) {
    switch (initials) {
      case 'haw':
        return 'Atlanta';
        break;
      case 'cel':
        return 'Boston';
        break;
      case 'net':
        return 'Brooklyn';
        break;
      case 'hor':
        return "Charlotte";
        break;
      case 'bul':
        return 'Chicago';
        break;
      case 'cav':
        return 'Cleveland';
        break;
      case 'mav':
        return "Dallas";
        break;
      case 'nug':
        return 'Denver';
        break;
      case 'pis':
        return 'Detroit';
        break;
      case 'war':
        return "Golden State";
        break;
      case 'hroc':
        return 'Houston';
        break;
      case 'pace':
        return 'Indiana';
        break;
      case 'cli':
        return "Los Angeles";
        break;
      case 'lak':
        return 'Los Angeles';
        break;
      case 'gri':
        return 'Memphis';
        break;
      case 'hea':
        return "Miami";
        break;
      case 'buck':
        return 'Milwaukee';
        break;
      case 'tim':
        return 'Minnesota';
        break;
      case 'pel':
        return "New Orleans";
        break;
      case 'kni':
        return 'New York';
        break;
      case 'thu':
        return 'Oklahoma City';
        break;
      case 'mag':
        return "Orlando";
        break;
      case '76e':
        return 'Philadelphia';
        break;
      case 'sun':
        return 'Phoenix';
        break;
      case 'tra':
        return "Portland";
        break;
      case 'skin':
        return 'Sacramento';
        break;
      case 'spu':
        return "San Antonio";
        break;
      case 'rap':
        return 'Toronto';
        break;
      case 'jaz':
        return 'Utah';
        break;
      case 'wiz':
        return "Washington";
        break;
      // NFL
      case 'acar':
        return 'Arizona';
        break;
      case 'fal':
        return 'Atlanta';
        break;
      case 'rav':
        return "Baltimore";
        break;
      case 'bil':
        return 'Buffalo';
        break;
      case 'cpan':
        return 'Carolina';
        break;
      case 'bea':
        return "Chicago";
        break;
      case 'ben':
        return 'Cincinnati';
        break;
      case 'brow':
        return 'Cleveland';
        break;
      case 'cow':
        return "Dallas";
        break;
      case 'bron':
        return 'Denver';
        break;
      case 'lio':
        return 'Detroit';
        break;
      case 'pack':
        return 'Green Bay';
        break;
      case 'tex':
        return 'Houston';
        break;
      case 'col':
        return 'Indianapolis';
        break;
      case 'jag':
        return 'Jacksonville';
        break;
      case 'chi':
        return 'Kansas City';
        break;
      case 'cha':
        return 'Los Angeles';
        break;
      case 'ram':
        return 'Los Angeles';
        break;
      case 'dol':
        return 'Miami';
        break;
      case 'vik':
        return 'Minnesota';
        break;
      case 'pat':
        return 'New England';
        break;
      case 'sai':
        return 'New Orleans';
        break;
      case 'ngia':
        return 'New York';
        break;
      case 'njet':
        return 'New York';
        break;
      case 'rai':
        return 'Oakland';
        break;
      case 'eag':
        return 'Philadelphia';
        break;
      case 'ste':
        return 'Pittsburgh';
        break;
      case '49e':
        return 'San Francisco';
        break;
      case 'sea':
        return 'Seattle';
        break;
      case 'bucc':
        return 'Tampa Bay';
        break;
      case 'tit':
        return 'Tennessee';
        break;
      case 'foo':
        return 'Washington';
        break;
      //NHL
      case 'duc':
        return 'Anaheim';
        break;
      case 'coy':
        return 'Arizona';
        break;
      case 'bru':
        return 'Boston';
        break;
      case 'sab':
        return 'Buffalo';
        break;
      case 'fla':
        return 'Calgary';
        break;
      case 'hur':
        return 'Carolina';
        break;
      case 'bla':
        return 'Chicago';
        break;
      case 'ava':
        return 'Colorado';
        break;
      case 'bluj':
        return 'Columbus';
        break;
      case 'sta':
        return 'Dallas';
        break;
      case 'rdwi':
        return 'Detroit';
        break;
      case 'oil':
        return 'Edmonton';
        break;
      case 'fpan':
        return 'Florida';
        break;
      case 'lkin':
        return 'Los Angeles';
        break;
      case 'wil':
        return 'Minnesota';
        break;
      case 'cana':
        return 'Montreal';
        break;
      case 'pre':
        return 'Nashville';
        break;
      case 'dev':
        return 'New Jersey';
        break;
      case 'isl':
        return 'New York';
        break;
      case 'nran':
        return 'New York';
        break;
      case 'sen':
        return 'Ottawa';
        break;
      case 'fly':
        return 'Philadelphia';
        break;
      case 'pen':
        return 'Pittsburgh';
        break;
      case 'sha':
        return 'San Jose';
        break;
      case 'blue':
        return 'St. Louis';
        break;
      case 'lig':
        return 'Tampa Bay';
        break;
      case 'lea':
        return 'Toronto';
        break;
      case 'canu':
        return 'Vancouver';
        break;
      case 'gol':
        return 'Vegas';
        break;
      case 'cap':
        return 'Washington';
        break;
      case 'wjet':
        return 'Winnipeg';
        break;
      //MLB
      case 'dia':
        return 'Arizona';
        break;
      case 'bra':
        return 'Atlanta';
        break;
      case 'ori':
        return 'Baltimore';
        break;
      case 'rdso':
        return 'Boston';
        break;
      case 'whi':
        return 'Chicago';
        break;
      case 'cub':
        return 'Chicago';
        break;
      case 'reds':
        return 'Cincinnati';
        break;
      case 'ind':
        return 'Cleveland';
        break;
      case 'croc':
        return 'Colorado';
        break;
      case 'tig':
        return 'Detroit';
        break;
      case 'ast':
        return 'Houston';
        break;
      case 'roy':
        return 'Kansas City';
        break;
      case 'ang':
        return 'Los Angeles';
        break;
      case 'dod':
        return 'Los Angeles';
        break;
      case 'mmar':
        return 'Miami';
        break;
      case 'bre':
        return 'Milwaukee';
        break;
      case 'twi':
        return 'Minnesota';
        break;
      case 'yan':
        return 'New York';
        break;
      case 'met':
        return 'New York';
        break;
      case 'ath':
        return 'Oakland';
        break;
      case 'phi':
        return 'Philadelphia';
        break;
      case 'pir':
        return 'Pittsburgh';
        break;
      case 'pad':
        return 'San Diego';
        break;
      case 'sgia':
        return 'San Francisco';
        break;
      case 'smar':
        return 'Seattle';
        break;
      case 'scar':
        return 'St. Louis';
        break;
      case 'ray':
        return 'Tampa Bay';
        break;
      case 'tran':
        return 'Texas';
        break;
      case 'blja':
        return 'Toronto';
        break;
      case 'nat':
        return 'Washington';
        break;
      default:
        return initials;
    }
  }

  String teamFromInitials(String initials) {
    return uncapitalizedTeamFromInitials(initials).toUpperCase();
  }

  String cityFromInitials(String initials) {
    return uncapitalizedCityFromInitials(initials).toUpperCase();
  }
}
