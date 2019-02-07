//import 'package:flutter_app2/lib1/ezlog.dart' hide wtf;
import 'package:flutter_app2/lib1/ezlog.dart' hide Level;
import 'package:flutter_app2/lib2/fastlog.dart' as fastlog show Logger, logi;

void entrance17() {
  print("enter entrance17");

  testImport();
  print("exit entrance17");
}

void testImport() {
  Logger.d("one");
  // as 为同名标识符定义别名
  fastlog.Logger.d("two");

  //hide wtf 无效，hide/show 的是dart文件里的顶层元素：类或者顶层函数；而不是类的方法
  Logger.wtf("aa");

  // hide 隐藏了ezlog.dart中的Level枚举类
//  Logger.level = Level.warn;
  // show 可以指定多个顶层标识符，同一个文件中未被show声明的标识符不可用
  fastlog.logi("three");
//  fastlog.logw("four");
}
