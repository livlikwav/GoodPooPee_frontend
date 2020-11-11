import 'dart:developer' as developer;

class MyLogger {
  // Can't be initialized in runtime
  MyLogger._();

  static void debug(String text) {
    developer.log(
      text,
      name: 'DEBUG',
      level: 10,
    );
  }

  static void info(String text) {
    developer.log(
      text,
      name: 'INFO',
      level: 20,
    );
  }

  static void error(String text) {
    developer.log(
      text,
      name: 'ERROR',
      level: 30,
    );
  }
}
