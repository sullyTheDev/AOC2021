import '../shared/file-reader.dart';
void main() {
  var inputStream = FileReader.read('problem-input.txt').asStream();
  var sanitizedInput = inputStream.map((data) => 
    data.map((command) {
      var commandArray = command.split(' ');
      return new Command(commandArray[0], int.parse(commandArray[1]));
    }).toList()
  )
  .first;

  problemSolution(sanitizedInput);
  problem2Solution(sanitizedInput);
}

void problemSolution(Future<List<Command>> input) async {
  var tracker = new PositionTrackerV1();
  var actualizedInput = await input;

  actualizedInput.forEach((element) {
    tracker.move(element.direction, element.value);
  });
  var positionValue = tracker.currentPosition();
  print(positionValue[0] * positionValue[1]);
}

void problem2Solution(Future<List<Command>> input) async {
  var tracker = new PositionTrackerV2();
  var actualizedInput = await input;

  actualizedInput.forEach((element) {
    tracker.move(element.direction, element.value);
  });
  var positionValue = tracker.currentPosition();
  print(positionValue[0] * positionValue[1]);
}



class Command {
  String direction;
  int value;

  Command(this.direction, this.value);
}

abstract class PositionTracker {
  int xPos = 0;
  int yPos = 0;

  void moveHorizontally(String direction, int units);
  void moveVertically(String direction, int units);
  void move(String direction, int units);

  List<int> currentPosition() {
    return [this.xPos, this.yPos];
  }
}

class PositionTrackerV1 extends PositionTracker {
  int xPos = 0;
  int yPos = 0;

  void moveHorizontally(String direction, int units) {
    switch (direction) {
      case 'forward' :
        this.xPos += units;
        break;
      default:
      this.xPos = this.xPos;
    }
  }

  void moveVertically(String direction, int units) {
    switch (direction) {
      case 'up':
        this.yPos -= units;
        break;
      case 'down':
        this.yPos += units;
        break;
      default:
    }
  }

  void move(String direction, int units) {
    if(direction == 'forward') {
      this.moveHorizontally(direction, units);
    } else if(direction == 'up' || direction == 'down') {
      this.moveVertically(direction, units);
    }
  }
}

class PositionTrackerV2 extends PositionTracker {
  int xPos = 0;
  int yPos = 0;
  int aim = 0;

  void moveHorizontally(String direction, int units) {
    switch (direction) {
      case 'forward' :
        this.xPos += units;
        this.yPos += (this.aim * units);
        break;
      default:
      this.xPos = this.xPos;
    }
  }

  void moveVertically(String direction, int units) {
    switch (direction) {
      case 'up':
        this.aim -= units;
        break;
      case 'down':
        this.aim += units;
        break;
      default:
    }
  }

  void move(String direction, int units) {
    if(direction == 'forward') {
      this.moveHorizontally(direction, units);
    } else if(direction == 'up' || direction == 'down') {
      this.moveVertically(direction, units);
    }
  }

  List<int> currentPosition() {
    return [this.xPos, this.yPos];
  }
}