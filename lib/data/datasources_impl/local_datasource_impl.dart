import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/local_datasouce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImpl extends LocalDataSource {
  LocalDataSourceImpl(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  @override
  String getString(String key) {
    try {
      sharedPreferences.reload();
      final result = sharedPreferences.getString(key);
      if (result != null) {
        return result;
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveString(String key, String data) async {
    return sharedPreferences.setString(key, data).catchError((e) {
      throw CacheException();
    }).then((_) async {
      await sharedPreferences.reload();
    });
  }

  @override
  Future<double> getDouble(String key) {
    try {
      final result = sharedPreferences.getDouble(key);
      if (result != null) {
        return Future.value(result);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<int> getInt(String key) {
    try {
      final result = sharedPreferences.getInt(key);
      if (result != null) {
        return Future.value(result);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<dynamic> getData(String key) {
    try {
      final result = sharedPreferences.get(key);
      if (result != null) {
        return Future.value(result);
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveDouble(String key, double data) async {
    return sharedPreferences.setDouble(key, data).catchError((e) {
      throw CacheException();
    }).then((_) async {
      await sharedPreferences.reload();
    });
  }

  @override
  Future<void> saveInt(String key, int data) async {
    return sharedPreferences.setInt(key, data).catchError((e) {
      throw CacheException();
    }).then((_) async {
      await sharedPreferences.reload();
    });
  }

  @override
  Future<bool> removeData(String key) async {
    try {
      if (sharedPreferences.containsKey(key)) {
        return await sharedPreferences.remove(key).then((value) async {
          await sharedPreferences.reload();
          return value;
        });
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  bool checkForData(String key) {
    try {
      final result = sharedPreferences.containsKey(key);
      if (result == null) {
        return false;
      } else {
        return result;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> removeAllUserData() async {
    try {
      await sharedPreferences.clear();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> reloadData() async {
    try {
      await sharedPreferences.reload();
    } catch (e) {
      throw CacheException();
    }
  }
}
