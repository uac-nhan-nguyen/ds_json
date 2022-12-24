class JsonMapObject {
  final Map<String, dynamic> data;

  JsonMapObject(this.data);

  double getDouble(String key) {
    try {
      if (data[key] is int) {
        return (data[key] as int).toDouble();
      } else if (data[key] is double) {
        return data[key] as double;
      } else {
        return double.parse((data[key] ?? '0') as String);
      }
    } catch (e) {
      throw 'Invalid data format key[${key}] runtimeType=${data[key].runtimeType} data=${data}: ${e.toString()}';
    }
  }

  double getDoubleRecursive(List<String> keys) {
    assert(keys.isNotEmpty);
    if (keys.length == 1) {
      return getDouble(keys.first);
    } else {
      return getObjectOrNull(keys.first)?.getDoubleRecursive(keys.sublist(1)) ?? 0;
    }
  }

  double? getDoubleOrNull(String key) {
    if (data[key] == null) return null;
    try {
      return double.parse((data[key] ?? '0') as String);
    } catch (e) {
      throw 'Invalid data format key[${key}] runtimeType=${data[key].runtimeType} data=${data}: ${e.toString()}';
    }
  }

  int getInt(String key) => (data[key] ?? 0) as int;

  int getIntParse(String key) => int.parse(getString(key));

  int getIntRecursive(List<String> keys) {
    assert(keys.isNotEmpty);
    if (keys.length == 1) {
      return getInt(keys.first);
    } else {
      return getObjectOrNull(keys.first)?.getIntRecursive(keys.sublist(1)) ?? 0;
    }
  }

  num getNum(String key) => (data[key] ?? 0) as num;

  int? getIntOrNull(String key) => data[key] == null ? null : data[key] as int;

  bool getBool(String key) => (data[key] ?? false) as bool;

  bool getBoolRecursive(List<String> keys) {
    assert(keys.isNotEmpty);
    if (keys.length == 1) {
      return getBool(keys.first);
    } else {
      return getObjectOrNull(keys.first)?.getBoolRecursive(keys.sublist(1)) ?? false;
    }
  }

  bool? getBoolOrNull(String key) => data[key] == null ? null : data[key] as bool;

  bool hasKey(String key) => data[key] != null;

  String getString(String key) => (data[key] ?? '') as String;

  String getStringRecursive(List<String> keys) {
    assert(keys.isNotEmpty);
    if (keys.length == 1) {
      return getString(keys.first);
    } else {
      return getObjectOrNull(keys.first)?.getStringRecursive(keys.sublist(1)) ?? '';
    }
  }

  String? getStringRecursiveOrNull(List<String> keys) {
    assert(keys.isNotEmpty);
    if (keys.length == 1) {
      return getStringOrNull(keys.first);
    } else {
      return getObjectOrNull(keys.first)?.getStringRecursiveOrNull(keys.sublist(1));
    }
  }

  String? getStringOrNull(String key) => data[key] == null ? null : data[key] as String;

  JsonMapObject getObject(String key) => JsonMapObject(data[key] as Map<String, dynamic>);

  JsonMapObject? getObjectOrNull(String key) => data[key] == null ? null : JsonMapObject(data[key] as Map<String, dynamic>);

  Map<String, dynamic> getObjectData(String key) => data[key] as Map<String, dynamic>;

  Map<String, dynamic>? getObjectDataOrNull(String key) => data[key] == null ? null : data[key] as Map<String, dynamic>;

  List<T> getList<T>(String key, T Function(Map<String, dynamic> data) creator) => ((data[key] ?? <dynamic>[]) as List<dynamic>).map((dynamic e) => creator(e as Map<String, dynamic>)).toList();

  List<String> getListString(String key) => ((data[key] ?? <dynamic>[]) as List<dynamic>).map((dynamic e) => e as String).toList();

  List<T> getListRecursive<T>(List<String> keys, T Function(Map<String, dynamic> data) creator) {
    assert(keys.isNotEmpty);
    if (keys.length == 1) {
      return getList(keys.first, creator);
    } else {
      return getObjectOrNull(keys.first)?.getListRecursive(keys.sublist(1), creator) ?? [];
    }
  }
}

class JsonArrayObject {
  final List<dynamic> data;

  JsonArrayObject(this.data);

  double getDouble(int index) {
    try {
      return double.parse((data[index] ?? '0') as String);
    } catch (e) {
      throw 'Invalid data format index[${index}] runtimeType=${data[index].runtimeType} data=${data}: ${e.toString()}';
    }
  }

  int getInt(int index) => (data[index] ?? 0) as int;

  String getString(int index) => (data[index] ?? '') as String;

  JsonMapObject getObject(int index) => JsonMapObject(data[index] as Map<String, dynamic>);
}
