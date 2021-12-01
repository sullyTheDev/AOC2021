import 'dart:async';
import 'dart:io';

class FileReader {
  static Future<List<String>> read(String path) async {
    try {
      return File(path).readAsLines();
    }
    catch(e) {
      print(e);
      return new Future(() => []);
    }
  } 
}