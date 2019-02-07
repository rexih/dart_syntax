void entrance13() {
  print("enter entrance13");

  // 回调处理future结果
  requestUserInfoByClosure("bill");
  // 传入函数指针处理future结果
  requestUserInfoByFunctionRef("rex");

  requestAddrByChain("lucky");
  requestAddrByChain("lily");

  requestUserDetail("rex");
  requestUserDetailWithError("lucky");
//  requestUserDetailWithError("rex");

  requestUserWithCatch("lucky");
  requestUserWithOnError("lucky");
  requestAddressWithCatch("denny");

  print("exit entrance13");
}

class User {
  int id;
  String name;
  String password;
  int age;
  String addr;

  User(this.id, this.name, this.password, this.age);

  @override
  String toString() {
    return 'User{id: $id, name: $name, password: $password, age: $age, addr: $addr}';
  }
}

class UserDetail extends User {
  String lastOrder;
  String lastCoupon;

  UserDetail(User user) : super(user.id, user.name, user.password, user.age);

  @override
  String toString() {
    return 'UserDetail{lastOrder: $lastOrder, lastCoupon: $lastCoupon, ${super.toString()}';
  }
}

Future<User> getUserInfo(String name) {
  return Future<User>.delayed(Duration(seconds: 4), () {
    if ("rex" == name) {
      return new User(1, "rex", "super123", 12);
    } else if ("lucky" == name) {
      throw Exception("forbidden user");
    } else if ("tom" == name) {
      return new User(4, "tom", "123456", 20);
    } else {
      return new User(0, "anonymous", "123456", 33);
    }
  });
}

User getAddressSync(User user) {
  var name = user.name;
  if ("rex" == name) {
    user.addr = "Nanjing";
  } else if ("lucky" == name) {
    user.addr = "unknown";
  } else if ("tom" == name) {
    throw "tom is dead";
  } else {
    throw NullThrownError();
  }

  return user;
}

class Order {
  int id;
  String orderName;
  String userName;

  Order(this.id, this.orderName, this.userName);

  @override
  String toString() {
    return 'Order{id: $id, orderName: $orderName, userName: $userName}';
  }
}

class Coupon {
  int id;
  String couponName;
  String userName;

  Coupon(this.id, this.couponName, this.userName);

  @override
  String toString() {
    return 'Coupon{id: $id, couponName: $couponName, userName: $userName}';
  }
}

Future<Order> getLastOrder(String name) {
  return Future<Order>.delayed(Duration(seconds: 2), () {
    if ("rex" == name) {
      return new Order(1, "movie", "rex");
    } else if ("lucky" == name) {
      return new Order(3, "lunch", "lucky");
    } else {
      return new Order(9, "tax", "anonymous");
    }
  });
}

Future<Coupon> getLastCoupon(String name) {
  return Future<Coupon>.delayed(Duration(seconds: 6), () {
    if ("rex" == name) {
      return new Coupon(5, "coffe", "rex");
    } else if ("lucky" == name) {
      return new Coupon(31, "orange", "lucky");
    } else {
      return new Coupon(49, "delivery", "anonymous");
    }
  });
}

void requestUserInfoByClosure(String name) {
  print("enter requestUserInfoByClosure");
  getUserInfo(name).then((User user) {
    print("user info: name:${user.name};age:${user.age}");
  });
  print("exit requestUserInfoByClosure");
}

void requestUserInfoByFunctionRef(String name) {
  print("enter requestUserInfoByFunctionRef");
  getUserInfo(name).then(printUser);
  print("exit requestUserInfoByFunctionRef");
}

void printUser(User user) {
  print("user info2: name:${user.name};age:${user.age};addr:${user.addr}");
}

void requestAddrByChain(String name) {
  print("enter requestAddrByChain");
  getUserInfo(name)
      .then(getAddressSync)
      .then(printUser)
      .catchError((e, stacktrace) {
    print("stacktrace : ${stacktrace}");
  });
  print("exit requestAddrByChain");
}

void requestUserDetail(String name) {
  print("enter requestUserAndOrder");

  // wait中集合的顺序，即为then中list值的顺序，即使user比order先返回
  Future.wait([getLastOrder(name), getUserInfo(name), getLastCoupon(name)])
      .then((List resp) {
//    resp.forEach(print);
    var orderUser = UserDetail(resp[1])
      ..lastOrder = resp[0].orderName
      ..lastCoupon = resp[2].couponName;
    return orderUser;
  }).then(print);

  print("exit requestUserAndOrder");
}

void requestUserDetailWithError(String name) {
  print("enter requestUserDetailWithError");

  // cleanUp回调，如果所有Future都正常执行，则不会被触发
  // cleanUp回调在部分Future抛出异常，部分Future正常返回的情况下会被多次触发（由成功的Future触发）
  // cleanUp被触发的顺序：在异常产生前返回的Future，按照返回的先后顺序触发，在异常产生后返回的Future，按照wait中集合的顺序触发

  // 看完源码更晕了，暂时不要纠结执行顺序的问题了，只要所有Future都正常执行，则list是按照wait中集合的顺序存储的
  Future.wait([getLastOrder(name), getUserInfo(name), getLastCoupon(name)],
      cleanUp: (successValue) {
    print(successValue);
  }).then((List resp) {
    resp.forEach(print);
    var orderUser = UserDetail(resp[1])
      ..lastOrder = resp[0].orderName
      ..lastCoupon = resp[2].couponName;
    return orderUser;
  }).then(print);

  print("exit requestUserDetailWithError");
}

Future<User> getUserImm(String name) {
  return Future<User>(() {
    if ("rex" == name) {
      return new User(1, "rex", "super123", 12);
    } else if ("lucky" == name) {
      throw Exception("forbidden user");
    } else {
      return new User(0, "anonymous", "123456", 20);
    }
  });
}

void requestUserWithCatch(String name) {
  print("enter requestUserWithCatch");
  getUserInfo(name).then(printUser).catchError((e) {
    print("caught error: ${e}");
  });
  print("exit requestUserWithCatch");
}

void requestUserWithOnError(String name) {
  print("enter requestUserWithOnError");
  getUserInfo(name).then(printUser, onError: (e, stackTrace) {
    print("requestUserWithOnError:onError:\ne=${e}\nstackTrace=${stackTrace}");
  });
  print("exit requestUserWithOnError");
}

void requestAddressWithCatch(String name) {
  print("enter requestAddressWithCatch");
  getUserInfo(name).then(getAddressSync).catchError((e) {
    print("caught NullThrownError with test: ${e}");
    return User(0, "anonymous", "123456", 33)..addr = "big street";
  }, test: (e) => e is NullThrownError).catchError((e) {
    print("caught error with test: ${e}");
  }).then(printUser);
  print("exit requestAddressWithCatch");
}

