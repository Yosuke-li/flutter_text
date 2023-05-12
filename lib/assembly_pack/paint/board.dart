mixin Board {
  late List<List<int>> board;
  late int size;

  void init({required int col}) {
    size = col;
    board = List<List<int>>.generate(size, (_) => List<int>.generate(size, (_) => 0));
  }

  bool checkWin(int row, int col, int player) {
    // 横向检查
    int count = 0;
    for (int i = 0; i < size; i++) {
      if (board[row][i] == player) {
        count++;
        if (count == 5) return true;
      } else {
        count = 0;
      }
    }

    // 纵向检查
    count = 0;
    for (int i = 0; i < size; i++) {
      if (board[i][col] == player) {
        count++;
        if (count == 5) return true;
      } else {
        count = 0;
      }
    }

    // 右上到左下斜线检查
    count = 0;
    for (int i = -4; i <= 4; i++) {
      int r = row + i;
      int c = col - i;
      if (r < 0 || r >= size || c < 0 || c >= size) continue;
      if (board[r][c] == player) {
        count++;
        if (count == 5) return true;
      } else {
        count = 0;
      }
    }

    // 左上到右下斜线检查
    count = 0;
    for (int i = -4; i <= 4; i++) {
      int r = row + i;
      int c = col + i;
      if (r < 0 || r >= size || c < 0 || c >= size) continue;
      if (board[r][c] == player) {
        count++;
        if (count == 5) return true;
      } else {
        count = 0;
      }
    }

    return false;
  }

  void printBoard() {
    for (int i = 0; i < size; i++) {
      print(board[i].join(' '));
    }
  }
}