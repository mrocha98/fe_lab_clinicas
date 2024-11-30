import 'package:fe_lab_clinicas_core/src/exceptions/core_exception.dart';

class UnsupportedStorageTypeException<T> extends CoreException {
  const UnsupportedStorageTypeException()
      : super(message: 'type $T is unsupported');
}
