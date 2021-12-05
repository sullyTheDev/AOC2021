import '../shared/file-reader.dart';
void main() async {
  var rawInput = await FileReader.read('C:/repos/AOC2021/day-4/problem-input.txt');

  List<int> numberCalls = rawInput.first.split(',').map((e) => int.parse(e)).toList();
  List<List<int>> tempBoardData = [];
  List<BingoBoard> boards = [];
  for (var row in rawInput.sublist(2)) {
    var sanitizedRow = row.split(' ').map((e) => e.trim()).where((element) => element != '').join(' ');
    if(sanitizedRow != '' ) {
      tempBoardData.add(sanitizedRow.split(' ').map((e) => int.parse(e)).toList());
      if(rawInput.indexOf(row) == rawInput.length - 1) {
        boards.add(new BingoBoard(List.from(tempBoardData)));
      }
    } else {
      boards.add(new BingoBoard(List.from(tempBoardData)));
      tempBoardData.clear();
    }
  }
  bool noWinner = false;
  do {
    bool winner = false;
    outerLoop:   
    for (var numberCalled in numberCalls) {
      for (var board in boards) {
        if(!board.won) {
          var won = board.checkNumber(numberCalled);
          if(won != null) {
            print(won);
            winner = true;
            board.won = true;
          }
        }
      }
      noWinner = numberCalls.last == numberCalled && !winner;
      if(noWinner == true) {
        print(numberCalled);
      }
    }
  } while (noWinner == false);
}

class Position {
  final int innerIndex;
  final int outerIndex;

  Position(this.innerIndex, this.outerIndex);
}



class BingoBoard {
  List<List<int>> numbers;
  BingoBoard(List<List<int>> this.numbers);
  List<Position> selected = [];
  bool won = false;

  int? checkNumber(int number) {
    for (var outerIndex = 0; outerIndex < this.numbers.length; outerIndex++) {
      for (var innerIndex = 0; innerIndex < this.numbers[outerIndex].length; innerIndex++) {
        if(this.numbers[outerIndex][innerIndex] == number) {
          this.selected.add(new Position(innerIndex, outerIndex));
          if(this.determineWin(outerIndex, innerIndex)) {
            return this.determineScore(outerIndex, innerIndex);
          }
          return null;
        }
      }
    }
  }

  bool determineWin(int outerIndex, int innerIndex) {
    var horizontalPattern = this.selected.map((pos) => pos.outerIndex).where((outer) => outer == outerIndex);
    var verticalPattern = this.selected.map((pos) => pos.innerIndex).where((inner) => inner == innerIndex);
    var horizontalWin = horizontalPattern.length == this.numbers[0].length;
    var verticalWin = verticalPattern.length == this.numbers.length;
    return horizontalWin || verticalWin;
  }

  int determineScore(int outerIndex, int innerIndex) {
    List<int> excludedNums = [];
    for (var pos in this.selected) {
      excludedNums.add(this.numbers[pos.outerIndex][pos.innerIndex]);
    }
    var sum = 0;
    this.numbers.forEach((element) {
      sum += element.reduce((value, element) => value + element);
    });
    sum -= excludedNums.reduce((value, element) => value + element);
    return sum * this.numbers[outerIndex][innerIndex];
  }
}