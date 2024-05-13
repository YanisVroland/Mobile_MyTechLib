/*
  This file contains classes for managing preferences, including saving and retrieving string values.
*/

import 'package:shared_preferences/shared_preferences.dart';

// Pref interface for defining preference methods
abstract class Pref {
  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);
}

// LocalPref class for managing preferences using shared preferences
class LocalPref extends Pref {
  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
}

// MemoryPref class for managing preferences using in-memory storage
class MemoryPref extends Pref {
  Map<String, Object> memoryMap = {};

  @override
  Future<String> getString(String key) {
    return Future.value(memoryMap[key] as String? ?? "");
  }

  @override
  Future<bool> saveString(String key, String value) async {
    memoryMap[key] = value;
    return true;
  }
}
