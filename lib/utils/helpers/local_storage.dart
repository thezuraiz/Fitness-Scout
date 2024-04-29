import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  static final TLocalStorage _instance = TLocalStorage._internal();
  SharedPreferences? _storage;

  factory TLocalStorage() {
    return _instance;
  }

  TLocalStorage._internal() {
    _initStorage();
  }

  Future<void> _initStorage() async {
    _storage = await SharedPreferences.getInstance();
  }

  // --- GENERIC METHOD TO SAVE DATA
  Future<void> saveData<T>(String key, T value) async {
    if (_storage == null) {
      // Handle the case where storage isn't initialized yet
      throw Exception("Storage is not initialized");
    }
    if (T == String) {
      await _storage!.setString(key, value as String);
    } else if (T == int) {
      await _storage!.setInt(key, value as int);
    } else if (T == double) {
      await _storage!.setDouble(key, value as double);
    } else if (T == bool) {
      await _storage!.setBool(key, value as bool);
    } else if (T == List<String>) {
      await _storage!.setStringList(key, value as List<String>);
    } else {
      // Handle unsupported type
      throw Exception("Unsupported data type");
    }
  }

  Future<T?> getData<T>(String key) async {
    if (T == String) {
      return _storage?.getString(key) as T?;
    } else if (T == int) {
      return _storage?.getInt(key) as T?;
    }
    else if(T == double){
      return _storage?.getDouble(key) as T?;
    }
    else if(T == bool){
      return _storage?.getBool(key) as T?;
    }
    else if(T == List<String>){
      return _storage?.getStringList(key) as T?;
    }
    return null;
  }

  Future removeData(String key)async{
    await _storage?.remove(key);
  }

  Future clearData()async{
    await _storage?.clear();
  }

}
