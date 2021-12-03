import '../shared/file-reader.dart';

void main() async {
  var data = await FileReader.read('C:/repos/AOC2021/day-3/problem-input.txt');
  var dataFinal = data.formData();

  problemSolution(dataFinal);
  problem2Solution(data);
}

void problemSolution(List<List<int>> input) {
  print(input.getGamma() * input.getEpsilon());
}

void problem2Solution(List<String> input) {
 var dataFormed = input.formData();

 print(dataFormed.getCO2Rating(input) * dataFormed.getOxygenRating(input));
}


extension on List<List<int>> {
  int getGamma() {
    String gamma = '';
    this.forEach((element) {
      gamma += element.where((bit) => bit == 1).length > element.where((bit) => bit == 0).length ? '1' : '0';
    });

    return int.parse(gamma, radix: 2);
  }

  int getEpsilon() {
    String epsilon = '';
    this.forEach((element) {
      epsilon += element.where((bit) => bit == 1).length > element.where((bit) => bit == 0).length ? '0' : '1';
    });

    return int.parse(epsilon, radix: 2);
  }

  int getOxygenRating(List<String> originalData) {
    String oxygenRating = '';
    List<List<int>> tempList = List.from(this);
    for (var i = 0; i < tempList.length; i++) {
      oxygenRating += tempList[i].where((bit) => bit == 1).length >= tempList[i].where((bit) => bit == 0).length ? '1' : '0';

      var filteredOGData = originalData.where((element) => element.startsWith(oxygenRating)).toList();
      tempList = filteredOGData.formData();

      if(filteredOGData.length == 1) {
        oxygenRating = filteredOGData[0];
        break;
      }
    }

    return int.parse(oxygenRating, radix: 2);
  }

  int getCO2Rating(List<String> originalData) {
    String co2Rating = '';
    List<List<int>> tempList = List.from(this);
    for (var i = 0; i < tempList.length; i++) {
      co2Rating += tempList[i].where((bit) => bit == 1).length >= tempList[i].where((bit) => bit == 0).length ? '0' : '1';

      var filteredOGData = originalData.where((element) => element.startsWith(co2Rating)).toList();
      tempList = filteredOGData.formData();

      if(filteredOGData.length == 1) {
        co2Rating = filteredOGData[0];
        break;
      }
    }

    return int.parse(co2Rating, radix: 2);
  }
}

extension on List<String> {
  List<List<int>> formData() {
    List<List<int>> dataFinal = [];

    //form data to something we can use...iterate over line data and convert to column data
    for(var i = 0; i < this.length; i++) {
      var intData = this[i].split('').map((e) => int.parse(e)).toList();
      for (var iter = 0; iter < intData.length; iter++) {
        if(i == 0) {
          dataFinal.add([intData[iter]]);
        } else {
          dataFinal[iter].add(intData[iter]);
        }
      }
    }

    return dataFinal;
  }
}