abstract class LocalDataSource {
  bool checkForData(String key);
  String getString(String key);
  Future<dynamic> getData(String key);
  Future<int> getInt(String key);
  Future<bool> removeData(String key);
  Future<double> getDouble(String key);
  Future<void> saveString(String key, String data);
  Future<void> saveInt(String key, int data);
  Future<void> saveDouble(String key, double data);
  Future<void> removeAllUserData();
  Future<void> reloadData();
}
