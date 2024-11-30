import 'package:fe_lab_clinicas_core/src/exceptions/exceptions.dart';
import 'package:fe_lab_clinicas_core/src/fp/fp.dart';

abstract interface class KeyValueStorage {
  Future<Either<UnsupportedStorageTypeException<V>, V?>> get<V>(String key);

  Future<bool> has(String key);

  Future<Either<UnsupportedStorageTypeException<V>, Unit>> set<V>(
    String key,
    V value,
  );

  Future<void> delete(String key);

  Future<void> deleteAll();
}
