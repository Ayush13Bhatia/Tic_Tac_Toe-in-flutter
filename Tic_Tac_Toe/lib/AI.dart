import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'game_button.dart';
import 'custon_Dialogs.dart';
import 'dart:math';

class AIGamePage extends StatefulWidget {
  @override
  _AIGamePageState createState() => _AIGamePageState();
}

class _AIGamePageState extends State<AIGamePage> {
  // TODO: importing the images
  AssetImage edit = AssetImage("images/edit.png");
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");

  List<GameButton> buttonsList;
  bool isCross = true;

  var player1;
  var player2;
  var activePlayer;
  String message;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    activePlayer = 1;
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = 'X';
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "O";
        gb.bg = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => CustomDialogs("Game Draw",
                  "Press the reset button to start again", resetGame));
        } else {
          activePlayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = List();
    var list = List.generate(9, (i) => i + 1);
    for (var cellId in list) {
      if (!(player1.contains(cellId) || player2.contains(cellId))) {
        emptyCells.add(cellId);
      }
    }
    var r = Random();
    var randonIndex = r.nextInt(emptyCells.length - 1);
    var cellId = emptyCells[randonIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellId);
    playGame(buttonsList[i]);
  }

  // TODO: AlertStyle
  AlertStyle alertDialog = AlertStyle(
      animationType: AnimationType.grow,
      animationDuration: Duration(
        milliseconds: 500,
      ),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ));

  int checkWinner() {
    var winner = -1;
    // row 1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }
    // diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialogs(
                "You Win", "Press the reset button to start again", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialogs("Computer Win",
                "Press the reset button to start again", resetGame));
      }
    }
    return winner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(60),
            child: Text(
              "Flutter Tic Tac Toe",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: buttonsList[i].enabled
                      ? () => playGame(buttonsList[i])
                      : null,
                  child: Text(
                    buttonsList[i].text,
                    style: TextStyle(color: Colors.red, fontSize: 50.0),
                  ),
                  color: buttonsList[i].bg,
                  disabledColor: buttonsList[i].bg,
                ),
                // child: Image(image: this.getImage(this.buttonsList[i])),
              ),
            ),
          ),
          MaterialButton(
              color: Colors.purple,
              minWidth: 300.0,
              height: 50.0,
              child: Text(
                "Reset Game",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: resetGame),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Project By: Ayush Bhatia",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
