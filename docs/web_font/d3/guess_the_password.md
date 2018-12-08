# guess the password

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div id="start-screen" class="show">
    <pre>
        _____                       _   _            _____                                    _
       / ____|                     | | | |          |  __ \                                  | |
      | |  __ _   _  ___  ___ ___  | |_| |__   ___  | |__) |_ _ ___ _____      _____  _ __ __| |
      | | |_ | | | |/ _ \/ __/ __| | __| '_ \ / _ \ |  ___/ _` / __/ __\ \ /\ / / _ \| '__/ _` |
      | |__| | |_| |  __/\__ \__ \ | |_| | | |  __/ | |  | (_| \__ \__ \\ V  V / (_) | | | (_| |
       \_____|\__,_|\___||___/___/  \__|_| |_|\___| |_|   \__,_|___/___/ \_/\_/ \___/|_|  \__,_|

    </pre>
    <p>Given a list of potential passwords, try to guess the correct one.</p>
    <p>If you're wrong, we'll tell you how many letters are correct.</p>
    <button id="start">Start</button>
  </div>
  <div id="game-screen" class="hide">
    <ul id="word-list"></ul>
    <p>Click on a word to make a guess.</p>
    <p id="guesses-remaining"></p>
    <p id="winner" class="hide">Congratulations! You win! <a href="./index.html">Play again?</a></p>
    <p id="loser" class="hide">Sorry, you lost. <a href="./index.html">Play again?</a></p>
  </div>
  <script src="https://d3js.org/d3.v4.min.js"></script>
  <script src="words.js"></script>
  <script src="app.js"></script>
</body>
</html>
```


```css
* {
  font-family: "Courier New";
  font-weight: bold;
  color: #00FF00;
}

body {
  background: black;
}

#start-screen,
#game-screen {
  text-align: center;
  overflow: hidden;  
}

#game-screen.show {
  transition-delay: 1s;
}

.show {
  max-height: 1000px;
  transition-duration: 1s;
  display: block;
}

.hide {
  max-height: 0;
  overflow: hidden;
  transition-duration: 1s;
}

#start {
  background-color: black;
  border: 5px solid #00FF00;
  border-radius: 5px;
  font-size: 3em;
  display: block;
  margin: 100px auto;
}

#start:hover {
  cursor: pointer;
  background-color: #00FF00;
  color: black;
}

#start:active,
#start:focus {
  outline: none;
}

#word-list {
  list-style-type: none;
  padding: 0;
}

#word-list > li {
  padding: 5px;
}

#word-list > li.disabled {
  color: #ccc;
}

#word-list > li:not(.disabled):hover {
  color: yellow;
  font-size: 1.5em;
  cursor: pointer;
}
```

```js
document.addEventListener('DOMContentLoaded', function() {
  var wordCount = 10;
  var guessCount = 4;
  var password = '';

  var start =  d3.select('#start')
      .on('click', function() {
      toggleClasses(d3.select('#start-screen'), 'hide', 'show');
      toggleClasses(d3.select('#game-screen'), 'hide', 'show');
      startGame();
  });

  function toggleClasses(selection) {
    for (var i = 1; i < arguments.length; i++) {
      var classIsSet = selection.classed(arguments[i]);
        selection.classed(arguments[i],!classIsSet);
    }
  }

  function startGame() {
    // get random words and append them to the DOM
    var wordList = d3.select("#word-list");
    var randomWords = getRandomValues(words, wordCount);
    randomWords.forEach(function(word) {
      wordList.append("li")
          .text(word);
    });

    // set a secret password and the guess count display
    password = getRandomValues(randomWords, 1)[0];
    setGuessCount(guessCount);

    // add update listener for clicking on a word
    wordList.on('click', updateGame);
  }

  function getRandomValues(array, numberOfVals) {
    return shuffle(array).slice(0, numberOfVals);
  }

  function shuffle(array) {
    var arrayCopy = array.slice();
    for (var idx1 = arrayCopy.length - 1; idx1 > 0; idx1--) {
      // generate a random index between 0 and idx1 (inclusive)
      var idx2 = Math.floor(Math.random() * (idx1 + 1));

      // swap elements at idx1 and idx2
      var temp = arrayCopy[idx1];
      arrayCopy[idx1] = arrayCopy[idx2];
      arrayCopy[idx2] = temp;
    }
    return arrayCopy;
  }

  function setGuessCount(newCount) {
    guessCount = newCount;
    d3.select("#guesses-remaining")
        .text("Guesses remaining: " + guessCount + ".");
  }

  function updateGame() {
      var tgt = d3.select(d3.event.target)
    if ( tgt.node().tagName === "LI" && ! tgt.classed("disabled")) {
      // grab guessed word, check it against password, update view
      var guess =  tgt.text();  // e.target.innerText;
      var similarityScore = compareWords(guess, password);
      tgt.classed("disabled",true)
          .text(guess+ " --> Matching Letters: " + similarityScore);
      setGuessCount(guessCount - 1);

      // check whether the game is over
      if (similarityScore === password.length) {
        toggleClasses(d3.select("#winner"), 'hide', 'show');
        d3.select('#click', null);
      } else if (guessCount === 0) {
        toggleClasses(d3.select("#loser"), 'hide', 'show');
        d3.select('#click', null);
      }
    }
  }

  function compareWords(word1, word2) {
    if (word1.length !== word2.length) throw "Words must have the same length";
    var count = 0;
    for (var i = 0; i < word1.length; i++) {
      if (word1[i] === word2[i]) count++;
    }
    return count;
  }
});
```

```js
var words = [
  "ability",
  "achieve",
  "acquire",
  "actions",
  "actress",
  "adopted",
  "adorned",
  "advises",
  "affront",
  "against",
  "airlock",
  "alcohol",
  "allowed",
  "already",
  "amalgam",
  "amongst",
  "amounts",
  "ancient",
  "android",
  "angelic",
  "angered",
  "anguish",
  "animals",
  "annoyed",
  "another",
  "answers",
  "anytime",
  "appears",
  "armored",
  "arrival",
  "arrived",
  "ashamed",
  "assigns",
  "assumed",
  "attacks",
  "attempt",
  "attends",
  "average",
  "awesome",
  "bandits",
  "banning",
  "banshee",
  "barrage",
  "barrens",
  "barrier",
  "bastard",
  "bastion",
  "battles",
  "beating",
  "because",
  "becomes",
  "bedroom",
  "beeping",
  "beliefs",
  "believe",
  "belongs",
  "benches",
  "beneath",
  "benefit",
  "besides",
  "between",
  "biggest",
  "bigotry",
  "bizarre",
  "blanket",
  "blasted",
  "blazing",
  "blessed",
  "blowing",
  "borrows",
  "bottles",
  "bracers",
  "briefly",
  "brother",
  "brought",
  "builder",
  "bundled",
  "burning",
  "burrows",
  "cabinet",
  "caliber",
  "calling",
  "camping",
  "cancers",
  "canteen",
  "cantina",
  "capable",
  "capitol",
  "captain",
  "captors",
  "capture",
  "caravan",
  "careful",
  "carried",
  "carrier",
  "carries",
  "causing",
  "caverns",
  "ceiling",
  "central",
  "ceramic",
  "certain",
  "chained",
  "chamber",
  "changed",
  "chooses",
  "circuit",
  "cistern",
  "citadel",
  "clawing",
  "cleanse",
  "cleared",
  "cleaver",
  "climate",
  "closely",
  "closest",
  "closing",
  "clothes",
  "cochise",
  "cohorts",
  "collect",
  "command",
  "commits",
  "company",
  "compass",
  "complex",
  "concern",
  "conduct",
  "confess",
  "confirm",
  "conquer",
  "consist",
  "consume",
  "contact",
  "contain",
  "content",
  "contest",
  "control",
  "cookery",
  "copying",
  "corners",
  "corrals",
  "costing",
  "council",
  "counter",
  "country",
  "cousins",
  "covered",
  "cowards",
  "crafted",
  "crazies",
  "created",
  "credits",
  "crimson",
  "cripple",
  "crossed",
  "crowbar",
  "crowded",
  "crucial",
  "crusade",
  "crushed",
  "curious",
  "current",
  "cutters",
  "cutting",
  "cyborgs",
  "daggers",
  "damaged",
  "dancers",
  "dancing",
  "dangers",
  "dealing",
  "deathly",
  "decades",
  "decided",
  "declare",
  "decline",
  "decorum",
  "decrees",
  "decried",
  "decries",
  "defeats",
  "defense",
  "demands",
  "denying",
  "departs",
  "deserts",
  "desired",
  "desires",
  "despair",
  "despite",
  "destroy",
  "details",
  "develop",
  "devices",
  "devious",
  "devolve",
  "disable",
  "disband",
  "discuss",
  "divided",
  "dollars",
  "doorway",
  "dragons",
  "drained",
  "dressed",
  "dresses",
  "driving",
  "dropped",
  "dungeon",
  "durable",
  "dusters",
  "dweller",
  "dwindle",
  "easiest",
  "effects",
  "efforts",
  "elderly",
  "elected",
  "elegant",
  "element",
  "embrace",
  "emerged",
  "emotion",
  "emperor",
  "enables",
  "encased",
  "enclave",
  "endings",
  "enemies",
  "enforce",
  "english",
  "enhance",
  "enslave",
  "ensuing",
  "erected",
  "errands",
  "escaped",
  "escapes",
  "escorts",
  "essence",
  "exactly",
  "exclaim",
  "expanse",
  "expects",
  "explain",
  "exposed",
  "express",
  "extract",
  "extreme",
  "faction",
  "failure",
  "falling",
  "fallout",
  "fanatic",
  "farming",
  "farther",
  "favored",
  "fearing",
  "feeling",
  "fencing",
  "fertile",
  "festers",
  "fighter",
  "filters",
  "finally",
  "finding",
  "firearm",
  "fishing",
  "fitting",
  "fizzles",
  "flowers",
  "flowing",
  "focused",
  "follows",
  "forbade",
  "forever",
  "fortify",
  "founded",
  "freedom",
  "freight",
  "friends",
  "further",
  "gabbing",
  "gaining",
  "gangers",
  "garbage",
  "gateway",
  "general",
  "genghis",
  "genuine",
  "getting",
  "ghengis",
  "ghostly",
  "godlike",
  "goggles",
  "gradual",
  "granite",
  "granted",
  "greatly",
  "greened",
  "greeted",
  "grenade",
  "grocery",
  "groomed",
  "grouped",
  "growing",
  "guarded",
  "gumming",
  "gunfire",
  "halberd",
  "hallway",
  "hammers",
  "handgun",
  "handles",
  "hanging",
  "hangout",
  "happens",
  "harmful",
  "harness",
  "hatchet",
  "hazards",
  "heading",
  "headset",
  "healing",
  "healthy",
  "hearing",
  "hearted",
  "heavens",
  "heavily",
  "heights",
  "helpful",
  "helping",
  "herself",
  "hideout",
  "himself",
  "hissing",
  "history",
  "holding",
  "holster",
  "horizon",
  "hostile",
  "housing",
  "however",
  "howling",
  "hundred",
  "hunters",
  "hunting",
  "hurting",
  "husband",
  "illness",
  "imagine",
  "implies",
  "improve",
  "include",
  "ingrown",
  "inhuman",
  "initial",
  "inquire",
  "insists",
  "instant",
  "instead",
  "instore",
  "insults",
  "intense",
  "invaded",
  "involve",
  "itching",
  "jackals",
  "jessica",
  "joining",
  "journal",
  "journey",
  "jungles",
  "justice",
  "jutting",
  "kedrick",
  "keeping",
  "kidnaps",
  "killing",
  "kindred",
  "kitchen",
  "knights",
  "knowing",
  "labeled",
  "landing",
  "lantern",
  "largest",
  "laughed",
  "laundry",
  "lawless",
  "leaders",
  "leading",
  "learned",
  "leather",
  "leaving",
  "lecture",
  "legends",
  "legions",
  "lending",
  "leprosy",
  "letting",
  "liberal",
  "library",
  "lighter",
  "limited",
  "locales",
  "located",
  "locking",
  "looking",
  "looting",
  "lowdown",
  "loyalty",
  "lurking",
  "machete",
  "machine",
  "maltase",
  "managed",
  "manages",
  "manhood",
  "mankind",
  "massive",
  "masters",
  "mastery",
  "matches",
  "matters",
  "maximum",
  "meaning",
  "meeting",
  "melissa",
  "melting",
  "members",
  "mention",
  "message",
  "messiah",
  "methods",
  "michael",
  "milling",
  "minigun",
  "minimal",
  "mirrors",
  "missing",
  "mission",
  "mixture",
  "molotov",
  "monitor",
  "monster",
  "monthly",
  "morning",
  "motives",
  "mounted",
  "mutants",
  "mutated",
  "mystery",
  "natural",
  "neglect",
  "neither",
  "nervous",
  "notable",
  "nothing",
  "noticed",
  "nourish",
  "nowhere",
  "nuclear",
  "nullmod",
  "numbers",
  "objects",
  "obvious",
  "october",
  "offense",
  "offered",
  "officer",
  "offices",
  "offline",
  "oneself",
  "opening",
  "options",
  "orbital",
  "ordered",
  "origins",
  "orleans",
  "outcast",
  "outcome",
  "outlaws",
  "outpost",
  "outrage",
  "outside",
  "overall",
  "overlap",
  "overrun",
  "oversee",
  "pacinko",
  "packets",
  "packing",
  "parents",
  "parties",
  "passing",
  "passion",
  "patches",
  "pattern",
  "penalty",
  "perfect",
  "periods",
  "persona",
  "physics",
  "picture",
  "pillage",
  "pillows",
  "pistols",
  "pitiful",
  "plagued",
  "planned",
  "plastic",
  "players",
  "playing",
  "pleased",
  "plotted",
  "pluming",
  "poisons",
  "popular",
  "pouring",
  "powered",
  "praised",
  "precise",
  "prepare",
  "present",
  "pressed",
  "priests",
  "primate",
  "prisons",
  "private",
  "problem",
  "proceed",
  "process",
  "produce",
  "project",
  "protect",
  "provide",
  "prowess",
  "psionic",
  "psychic",
  "puppets",
  "purpose",
  "putting",
  "puzzles",
  "pyramid",
  "qualify",
  "quality",
  "quickly",
  "raiders",
  "raiding",
  "rampage",
  "rangers",
  "ranking",
  "ransack",
  "rations",
  "ravages",
  "reached",
  "reaches",
  "reactor",
  "readily",
  "reading",
  "realize",
  "reasons",
  "rebuild",
  "receive",
  "records",
  "recover",
  "recruit",
  "reduced",
  "reenter",
  "refuses",
  "regular",
  "related",
  "release",
  "remains",
  "remorse",
  "removes",
  "require",
  "resides",
  "respect",
  "resting",
  "retired",
  "retreat",
  "returns",
  "revenge",
  "revered",
  "rhombus",
  "rituals",
  "roaming",
  "robbers",
  "roberts",
  "rodents",
  "routing",
  "rumbles",
  "rundown",
  "running",
  "salvage",
  "sanctum",
  "saviors",
  "scalpel",
  "sconces",
  "scraper",
  "screens",
  "scribes",
  "sealant",
  "sealing",
  "seaside",
  "secrets",
  "section",
  "seeking",
  "selling",
  "sending",
  "serious",
  "sermons",
  "servant",
  "service",
  "serving",
  "session",
  "setting",
  "settled",
  "several",
  "shadows",
  "sharper",
  "shelter",
  "shelves",
  "sheriff",
  "shotgun",
  "showing",
  "shrines",
  "shunned",
  "signals",
  "similar",
  "siphons",
  "skeptic",
  "sketchy",
  "skilled",
  "slammed",
  "slavers",
  "slavery",
  "sliding",
  "slipped",
  "slither",
  "slumber",
  "smaller",
  "smarter",
  "smashed",
  "smoking",
  "society",
  "soldier",
  "somehow",
  "someone",
  "sounded",
  "sparing",
  "special",
  "spotted",
  "stacked",
  "stained",
  "stamina",
  "started",
  "stating",
  "station",
  "statues",
  "staying",
  "stealth",
  "sterile",
  "stopped",
  "storage",
  "stories",
  "stormed",
  "strange",
  "streaks",
  "streets",
  "stripes",
  "studies",
  "stunned",
  "subject",
  "succeed",
  "success",
  "suggest",
  "support",
  "surface",
  "survive",
  "systems",
  "tactics",
  "tainted",
  "takings",
  "talents",
  "talking",
  "targets",
  "tattoos",
  "taunted",
  "teacher",
  "temples",
  "tenants",
  "testing",
  "theater",
  "theatre",
  "thicker",
  "thieves",
  "thirsty",
  "thought",
  "through",
  "thrower",
  "tonight",
  "toppled",
  "torches",
  "torture",
  "towards",
  "traders",
  "trading",
  "trained",
  "traitor",
  "treated",
  "trinity",
  "trouser",
  "trusted",
  "tunnels",
  "turrets",
  "twinkie",
  "twisted",
  "typical",
  "tyranny",
  "undergo",
  "unknown",
  "unlucky",
  "unusual",
  "uranium",
  "useless",
  "usually",
  "utensil",
  "variety",
  "various",
  "varying",
  "vassals",
  "veggies",
  "venture",
  "version",
  "victims",
  "victory",
  "village",
  "villain",
  "violate",
  "violent",
  "virtual",
  "visible",
  "visited",
  "volumes",
  "waiting",
  "walking",
  "walkway",
  "wanting",
  "warfare",
  "warlike",
  "warning",
  "warpath",
  "warring",
  "warrior",
  "wasting",
  "watched",
  "wealthy",
  "weapons",
  "wearing",
  "welcome",
  "welfare",
  "western",
  "whether",
  "whisper",
  "whoever",
  "willing",
  "winding",
  "windows",
  "winning",
  "wishing",
  "without",
  "wonders",
  "working",
  "worried",
  "worship",
  "wounded",
  "writing",
  "written",
  "younger",
  "zealots",
  "zealous"
];
```