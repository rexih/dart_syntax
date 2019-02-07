class Logger {

  static Level level = Level.info;


  static void v(String msg) {
    if (level.index >= Level.verbose.index) {
      print("ezlog: ${msg}");
    }
  }

  static void d(String msg) {
    if (level.index >= Level.debug.index) {
      print("ezlog: ${msg}");
    }
  }

  static void i(String msg) {
    if (level.index >= Level.info.index) {
      print("ezlog: ${msg}");
    }
  }

  static void w(String msg) {
    if (level.index >= Level.warn.index) {
      print("ezlog: ${msg}");
    }
  }

  static void e(String msg) {
    if (level.index >= Level.error.index) {
      print("ezlog: ${msg}");
    }
  }

  static void wtf(String msg) {
    if (level.index >= Level.fatal.index) {
      print("ezlog: ${msg}");
    }
  }





}

enum Level {
  verbose,debug,info,warn,error,fatal
}