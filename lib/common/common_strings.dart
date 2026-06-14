List<List<String>> wordCategories = [
  // Sports
  [
    'Run',
    'Kick',
    'Goal',
    'Team',
    'Race',
    'Score',
    'Bat',
    'Jump',
    'Net',
    'Win',
    'Gym',
    'Pass',
    'Hit',
    'Ball',
    'Coach',
  ],

  // Animals
  [
    'Cat',
    'Dog',
    'Lion',
    'Bear',
    'Wolf',
    'Frog',
    'Duck',
    'Goat',
    'Cow',
    'Bat',
    'Fish',
    'Mole',
    'Ox',
    'Rat',
    'Ant',
  ],

  // Transport
  [
    'Car',
    'Bus',
    'Bike',
    'Jeep',
    'Boat',
    'Ship',
    'Van',
    'Tram',
    'Train',
    'Cab',
    'Jets',
    'Cart',
    'Sled',
    'Taxi',
    'Yacht',
  ],

  // Places
  [
    'Home',
    'Mall',
    'Park',
    'Lake',
    'Bank',
    'Hill',
    'Shop',
    'Cave',
    'Farm',
    'Beach',
    'Port',
    'Hall',
    'City',
    'Fort',
    'Camp',
  ],

  // Countries
  [
    'China',
    'Spain',
    'Egypt',
    'India',
    'Brazil',
    'Japan',
    'Kenya',
    'Turkey',
    'Italy',
    'Chile',
    'Nepal',
    'France',
    'Qatar',
    'Greece',
    'Canada',
  ],
];

List<String> getSections = [
  'Sports',
  'Animals',
  'Transport',
  'Places',
  'Countries',
];

List<String> tutorialTexts = [
  // Part 1
  "Welcome to Spy Game!\nChoose the number of players (minimum 3) and the number of spies (at least 1, but no more than half the players).\nSelect one or more categories like Sports , Animals ,  Countries, Transport, Places, or Random. Words will come from these.",

  "Once the game starts, each player takes turns viewing their card.\nPlayers will see the same word.\nExcept the Spy.\nYour goal is to figure out who the spy is - or if you're the spy, guess the word!",

  // Part 2
  "On your turn:\nTap the card to reveal your word (or spy message).\nTap again to hide it and pass the phone to the next player.",

  "After everyone has seen their card, the timer starts.\nTalk in turns, give clever clues, and try not to reveal too much.\nAt the end, vote on who the spy is.\nIf the group finds the spy, they win. If the spy guesses the word, the spy wins!",
];

String spyLogo = 'assets/spy_logo.png';
