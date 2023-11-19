import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  static final LocalStorage _instance = LocalStorage._internal();
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setValue<T>(String key, T value) {
    switch (T) {
      case String:
        _prefs.setString(key, value as String);
      case bool:
        _prefs.setBool(key, value as bool);
      case int:
        _prefs.setInt(key, value as int);
      case double:
        _prefs.setDouble(key, value as double);
      case const (List<String>):
        _prefs.setStringList(key, value as List<String>);
      default:
        throw Exception('Unsupported type: ${T.runtimeType}');
    }
  }

  T? getValue<T>(String key) {
    if (T == String) {
      return _prefs.getString(key) as T?;
    } else if (T == bool) {
      return _prefs.getBool(key) as T?;
    } else if (T == int) {
      return _prefs.getInt(key) as T?;
    } else if (T == double) {
      return _prefs.getDouble(key) as T?;
    } else if (T == List<String>) {
      final value = _prefs.getStringList(key);
      if (value != null) {
        return value as T;
      }
      return null;
    } else {
      throw Exception('Unsupported type: ${T.runtimeType}');
    }
  }

  void clearStorage() {
    _prefs.clear();
  }
}
