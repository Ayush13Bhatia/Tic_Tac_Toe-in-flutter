import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // TODO: link up images

  AssetImage cross = AssetImage('images/cross.png');
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");

  bool isCross = true;
  String message;
  List<String> gameState;

  //TODO: initiazlie the state of box with empty
  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = " ";
    });
  }

  // TODO: AlertStyle
  AlertStyle alertStyle = AlertStyle(
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
    ),
  );

  //TODO: playGame method

  playGame(int index) {
    if (this.gameState[index] == 'empty') {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = 'cross';
        } else {
          this.gameState[index] = 'circle';
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  // TODO: alertDialogs
  AlertDialogBoxForWin(context, index) {
    Alert(
      closeFunction: resetGame,
      context: context,
      title: "${this.gameState[index]} win",
      buttons: [
        DialogButton(
            child: Text(
              "OK",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).setState(() {
                resetGame();
              });
            }),
      ],
      image: Image(
        image: getImage(this.gameState[index]),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.cover,
      ),
      style: alertStyle,
    ).show();
  }

  AlertDialogBoxforDraw(context) {
    Alert(
      context: context,
      closeFunction: resetGame,
      title: 'GAME DRAW',
      buttons: [
        DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).setState(() {
                resetGame();
              });
            }),
      ],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("images/cross.png"),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          Image(
            image: AssetImage("images/circle.png"),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
      style: alertStyle,
    ).show();
  }

  //TODO: Reset game method
  resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = " ";
    });
  }

  //TODO: get image method
  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
    }
  }

  //TODO: check for with logic
  checkWin() {
    // one
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      // if any user win update the message state
      setState(() {
        AlertDialogBoxForWin(context, 0);
        this.message = '${gameState[0]} Win';
      });
    } // Two
    else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        AlertDialogBoxForWin(context, 0);
        this.message = "${gameState[0]} Win";
      });
    } // Three
    else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        AlertDialogBoxForWin(context, 0);
        this.message = "${gameState[0]} win";
      });
    } // Four
    else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        AlertDialogBoxForWin(context, 1);
        this.message = "${this.gameState[1]} win";
      });
    }
    // Five
    else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        AlertDialogBoxForWin(context, 2);
        this.message = "${this.gameState[2]} win";
      });
    }
    // Six
    else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        AlertDialogBoxForWin(context, 3);
        this.message = "${this.gameState[3]} win";
      });
    }
    // Seven
    else if ((gameState[6] != "empty") &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        AlertDialogBoxForWin(context, 6);
        this.message = "${gameState[6]} Win";
      });
    }
    // Eight
    else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[4]) &&
        (gameState[4] == gameState[2])) {
      setState(() {
        AlertDialogBoxForWin(context, 6);
        this.message = '${this.gameState[6]} Win';
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.AlertDialogBoxforDraw(context);
        this.message = "Game Dram";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tic Tac Toe'),
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
                crossAxisSpacing: 10,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
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
            onPressed: () {
              this.resetGame();
            },
          ),
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
