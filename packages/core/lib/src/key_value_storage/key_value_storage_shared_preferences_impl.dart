import 'package:fe_lab_clinicas_core/src/exceptions/exceptions.dart';
import 'package:fe_lab_clinicas_core/src/fp/fp.dart';
import 'package:fe_lab_clinicas_core/src/key_value_storage/key_value_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageSharedPreferencesImpl implements KeyValueStorage {
  const KeyValueStorageSharedPreferencesImpl._internal();

  factory KeyValueStorageSharedPreferencesImpl.getInstance() {
    if (_instance == null) {
      _instance = const KeyValueStorageSharedPreferencesImpl._internal();
      SharedPreferences.setPrefix('LAB_CLINICAS_');
    }
    return _instance!;
  }

  static KeyValueStorageSharedPreferencesImpl? _instance;

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  @override
  Future<Either<UnsupportedStorageTypeException<V>, V?>> get<V>(
    String key,
  ) async {
    final prefs = await _prefs;
    switch (V) {
      case int:
      case double:
      case bool:
      case String:
        return Right(prefs.get(key) as V?);
      case const (List<String>):
        return Right(prefs.getStringList(key) as V?);
      default:
        return Left(UnsupportedStorageTypeException<V>());
    }
  }

  @override
  Future<void> deleteAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }

  @override
  Future<void> delete(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  @override
  Future<bool> has(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }

  @override
  Future<Either<UnsupportedStorageTypeException<V>, Unit>> set<V>(
    String key,
    V value,
  ) async {
    final prefs = await _prefs;
    switch (V) {
      case String:
        await prefs.setString(key, value as String);
        return Right.unit();
      case int:
        await prefs.setInt(key, value as int);
        return Right.unit();
      case double:
        await prefs.setDouble(key, value as double);
        return Right.unit();
      case bool:
        await prefs.setBool(key, value as bool);
        return Right.unit();
      case const (List<String>):
        await prefs.setStringList(key, value as List<String>);
        return Right.unit();
      default:
        return Left(UnsupportedStorageTypeException<V>());
    }
  }
}
