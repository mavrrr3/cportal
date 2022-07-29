import 'package:hive_flutter/hive_flutter.dart';

Future<Box<T>> forceOpenBox<T>(String boxName) async {
  Box<T> box = await Hive.openBox<T>(boxName);

  if (!Hive.isBoxOpen(boxName)) {
    await Hive.openBox<T>(boxName);
  } else {
    box = await Hive.openBox<T>(boxName);
  }

  return box;
}
