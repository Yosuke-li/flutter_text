import '../../init.dart';
import 'style.dart';

class AlertGameOver extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.secondaryBackgroundColor,
      title: Text(
        '游戏结束',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      content: Text(
        '恭喜通关该难度！',
        style: TextStyle(color: Styles.foregroundColor),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
            restartGame = true;
          },
          child: const Text('重新开始'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Styles.primaryColor)),
          onPressed: () {
            Navigator.pop(context);
            newGame = true;
          },
          child: const Text('新游戏'),
        ),
      ],
    );
  }
}

class AlertNumbersState extends StatefulWidget {
  @override
  AlertNumbers createState() => AlertNumbers();

  static int get number {
    return AlertNumbers.number;
  }

  static set number(int number) {
    AlertNumbers.number = number;
  }
}

class AlertNumbers extends State<AlertNumbersState> {
  static int number;
  int numberSelected;
  static final List<int> numberList1 = [1, 2, 3];
  static final List<int> numberList2 = [4, 5, 6];
  static final List<int> numberList3 = [7, 8, 9];

  List<SizedBox> createButtons(List<int> numberList) {
    return <SizedBox>[
      for (int numbers in numberList)
        SizedBox(
          width: 38,
          height: 38,
          child: TextButton(
            onPressed: () => {
              setState(() {
                numberSelected = numbers;
                number = numberSelected;
                Navigator.pop(context);
              })
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Styles.secondaryBackgroundColor),
              foregroundColor:
              MaterialStateProperty.all<Color>(Styles.primaryColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                color: Styles.foregroundColor,
                width: 1,
                style: BorderStyle.solid,
              )),
            ),
            child: Text(
              numbers.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
    ];
  }

  Row oneRow(List<int> numberList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(numberList),
    );
  }

  List<Row> createRows() {
    List<List> numberLists = [numberList1, numberList2, numberList3];
    List<Row> rowList = new List<Row>.filled(3, null);
    for (var i = 0; i <= 2; i++) {
      rowList[i] = oneRow(numberLists[i]);
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Styles.secondaryBackgroundColor,
        title: Center(
            child: Text(
              'Choose a Number',
              style: TextStyle(color: Styles.foregroundColor),
            )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createRows(),
        ));
  }
}