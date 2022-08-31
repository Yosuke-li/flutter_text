import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/animation/drop_selectable_widget.dart';
import 'package:flutter_text/init.dart';
import 'package:self_utils/utils/array_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import 'alert.dart';
import 'style.dart';

class SudoGamePage extends StatefulWidget {
  @override
  _SudoGameState createState() => _SudoGameState();
}

class _SudoGameState extends State<SudoGamePage> {
  bool firstRun = true;
  bool gameOver = false;
  bool gameSolution = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  late List<List<List<int>>> gameList;
  late List<List<int>> game;
  late List<List<int>> gameCopy;
  late List<List<int>> gameSolved;
  static String currentDifficultyLevel = 'easy';
  static String? currentAccentColor;
  static late String platform;

  static List<String> gameLevel = <String>[
    'test',
    'beginner',
    'easy',
    'medium',
    'hard'
  ];

  @override
  void initState() {
    super.initState();
    getPrefs().whenComplete(() {
      currentDifficultyLevel = 'easy';
      currentAccentColor = 'Blue';
      setPrefs('currentDifficultyLevel');
      setPrefs('currentAccentColor');
      newGame(currentDifficultyLevel);
      changeAccentColor(currentAccentColor!, true);
    });
    if (kIsWeb) {
      platform = 'web-' +
          defaultTargetPlatform
              .toString()
              .replaceFirst('TargetPlatform.', '')
              .toLowerCase();
    } else {
      platform = defaultTargetPlatform
          .toString()
          .replaceFirst('TargetPlatform.', '')
          .toLowerCase();
    }
  }

  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentDifficultyLevel = prefs.getString('currentDifficultyLevel')??'easy';
      currentAccentColor = prefs.getString('currentAccentColor');
    });
  }

  Future<void> setPrefs(String property) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (property == 'currentDifficultyLevel') {
      prefs.setString('currentDifficultyLevel', currentDifficultyLevel);
    } else if (property == 'currentAccentColor') {
      prefs.setString('currentAccentColor', currentAccentColor!);
    }
  }

  void changeAccentColor(String color, [bool firstRun = false]) {
    setState(() {
      if (Styles.accentColors.keys.contains(color)) {
        Styles.primaryColor = Styles.accentColors[color]!;
      } else {
        currentAccentColor = 'Blue';
        Styles.primaryColor = Styles.accentColors[color]!;
      }
      if (color == 'Red') {
        Styles.secondaryColor = Styles.orange;
      } else {
        Styles.secondaryColor = Styles.lightRed;
      }
      if (!firstRun) {
        setPrefs('currentAccentColor');
      }
    });
  }

  void checkResult() {
    try {
      if (SudokuUtilities.isSolved(game)) {
        isButtonDisabled = !isButtonDisabled;
        gameOver = true;
        Timer(const Duration(milliseconds: 500), () {
          showDialog(context: context, builder: (_) => AlertGameOver())
              .whenComplete(() {
            if (AlertGameOver.newGame) {
              newGame(currentDifficultyLevel);
              AlertGameOver.newGame = false;
            } else if (AlertGameOver.restartGame) {
              restartGame();
              AlertGameOver.restartGame = false;
            }
          });
        });
      }
    } on InvalidSudokuConfigurationException {
      return;
    }
  }

  static List<List<List<int>>> getNewGame([String difficulty = 'easy']) {
    late int emptySquares;
    switch (difficulty) {
      case 'test':
        {
          emptySquares = 2;
        }
        break;
      case 'beginner':
        {
          emptySquares = 18;
        }
        break;
      case 'easy':
        {
          emptySquares = 27;
        }
        break;
      case 'medium':
        {
          emptySquares = 36;
        }
        break;
      case 'hard':
        {
          emptySquares = 54;
        }
        break;
    }
    final SudokuGenerator generator =
        SudokuGenerator(emptySquares: emptySquares);
    return [generator.newSudoku, generator.newSudokuSolved];
  }

  void setGame(int mode, [String difficulty = 'easy']) {
    if (mode == 1) {
      game =
          List<List<int>>.generate(9, (int i) => [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = SudokuUtilities.copySudoku(game);
      gameSolved = SudokuUtilities.copySudoku(game);
    } else {
      gameList = getNewGame(difficulty);
      game = gameList[0];
      gameCopy = SudokuUtilities.copySudoku(game);
      gameSolved = gameList[1];
    }
  }

  void showSolution() {
    setState(() {
      gameSolution = true;
      Timer(const Duration(seconds: 5), () {
        gameSolution = false;
        setState(() {});
      });
    });
  }

  void newGame([String difficulty = 'easy']) {
    setState(() {
      setGame(2, difficulty);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  void restartGame() {
    setState(() {
      game = SudokuUtilities.copySudoku(gameCopy);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  Color buttonColor(int k, int i) {
    Color color;
    if (([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) ||
        ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) ||
        ([6, 7, 8].contains(k) && [3, 4, 5].contains(i))) {
      if (Styles.white == Styles.darkGrey) {
        color = Styles.grey;
      } else {
        color = Colors.grey[300]!;
      }
    } else {
      color = Styles.white;
    }

    return color;
  }

  double buttonSize() {
    double size = 50;
    if (_SudoGameState.platform.contains('android') ||
        _SudoGameState.platform.contains('ios')) {
      size = 38;
    }
    return size;
  }

  double buttonFontSize() {
    double size = 20;
    if (_SudoGameState.platform.contains('android') ||
        _SudoGameState.platform.contains('ios')) {
      size = 16;
    }
    return size;
  }

  BorderRadiusGeometry buttonEdgeRadius(int k, int i) {
    if (k == 0 && i == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(5));
    } else if (k == 0 && i == 8) {
      return const BorderRadius.only(topRight: Radius.circular(5));
    } else if (k == 8 && i == 0) {
      return const BorderRadius.only(bottomLeft: Radius.circular(5));
    } else if (k == 8 && i == 8) {
      return const BorderRadius.only(bottomRight: Radius.circular(5));
    }
    return BorderRadius.circular(0);
  }

  List<SizedBox> createButtons() {
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }
    MaterialColor emptyColor;
    if (gameOver) {
      emptyColor = Styles.primaryColor;
    } else {
      emptyColor = Styles.secondaryColor;
    }
    final List<SizedBox> buttonList = List<SizedBox>.filled(9, const SizedBox());
    for (int i = 0; i <= 8; i++) {
      int k = timesCalled;
      buttonList[i] = SizedBox(
        width: buttonSize(),
        height: buttonSize(),
        child: TextButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () {
                  showDialog<void>(
                      barrierDismissible: true,
                      context: context,
                      builder: (_) => AlertNumbersState()).whenComplete(() {
                    callback([k, i], AlertNumbersState.number);
                    AlertNumbersState.number = 0;
                  });
                },
          onLongPress: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i], 0),
          style: ButtonStyle(
            backgroundColor: isButtonDisabled || gameCopy[k][i] != 0 ||
                    game[k][i] == 0 ||
                    gameSolution == false
                ? MaterialStateProperty.all<Color>(buttonColor(k, i))
                : game[k][i] == gameSolved[k][i]
                    ? MaterialStateColor.resolveWith(
                        (_) => Styles.aospExtendedGreen.shade50)
                    : MaterialStateColor.resolveWith(
                        (_) => Styles.lightRed.shade50),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return gameCopy[k][i] == 0
                    ? emptyColor
                    : Styles.darkGrey;
              }
              return game[k][i] == 0
                  ? buttonColor(k, i)
                  : Styles.textColor;
            }),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: buttonEdgeRadius(k, i),
            )),
            side: MaterialStateProperty.all<BorderSide>(BorderSide(
              color: Styles.darkGrey,
              width: 1,
              style: BorderStyle.solid,
            )),
          ),
          child: Text(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: buttonFontSize()),
          ),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  Row oneRow() {
    return Row(
      children: createButtons(),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<Row> createRows() {
    final List<Row> rowList = List<Row>.filled(9, Row());
    for (int i = 0; i <= 8; i++) {
      rowList[i] = oneRow();
    }
    return rowList;
  }

  void callback(List<int> index, int number) {
    setState(() {
      if (number == null) {
        return;
      } else if (number == 0) {
        game[index[0]][index[1]] = number;
      } else {
        game[index[0]][index[1]] = number;
        checkResult();
      }
    });
  }

  void showOptionModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (BuildContext context) {
          final TextStyle customStyle =
              TextStyle(inherit: false, color: Styles.darkGrey);
          return Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.refresh, color: Styles.darkGrey),
                title: Text('Restart Game', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(const Duration(milliseconds: 200), () => restartGame());
                },
              ),
              ListTile(
                leading: Icon(Icons.add_rounded, color: Styles.darkGrey),
                title: Text('New Game', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(const Duration(milliseconds: 200),
                      () => newGame(currentDifficultyLevel));
                },
              ),
              ListTile(
                leading: Icon(Icons.lightbulb_outline_rounded,
                    color: Styles.darkGrey),
                title: Text('Show Solution', style: customStyle),
                onTap: () {
                  Navigator.pop(context);
                  Timer(
                      const Duration(milliseconds: 200), () => showSolution());
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (kIsWeb) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Styles.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: AppBar(
              centerTitle: true,
              title: const Text('数 独'),
              backgroundColor: Styles.primaryColor,
            )),
        body: Builder(builder: (BuildContext builder) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: screenUtil.adaptive(75),
                    right: screenUtil.adaptive(75)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('当前难度：$currentDifficultyLevel'),
                    RepaintBoundary(
                      child: DropSelectableWidget(
                        fontSize: 12,
                        data: gameLevel,
                        value: currentDifficultyLevel,
                        iconSize: 20,
                        height: 30,
                        width: 100,
                        widgetHeight: 150,
                        disableColor: const Color(0xff1F425F),
                        onDropSelected: (int index) async {
                          Log.info(index);
                          currentDifficultyLevel =
                              ArrayHelper.get(gameLevel, index)!;
                          newGame(currentDifficultyLevel);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              RepaintBoundary(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: createRows(),
                ),
              ),
            ],
          ));
        }),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Styles.white,
          backgroundColor: Styles.primaryColor,
          onPressed: () => showOptionModalSheet(context),
          child: const Icon(Icons.menu_rounded),
        ),
      ),
    );
  }
}
