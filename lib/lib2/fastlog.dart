class Logger {

  static void d(String msg) {
    print("fastlog: ${msg}");
  }

  static void i(String msg) {
    print("fastlog: ${msg}");
  }
  static void w(String msg) {
    print("fastlog: ${msg}");
  }
}


void logi(String msg) {
  Logger.i(msg);
}

void logw(String msg) {
  Logger.w(msg);
}