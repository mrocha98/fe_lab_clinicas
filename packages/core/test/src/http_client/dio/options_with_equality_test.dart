import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/http_client/dio/options_with_equality.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OptionsWithEquality', () {
    test('should extends from dio Options', () {
      expect(OptionsWithEquality(), isA<Options>());
    });

    test('should implement equality', () {
      expect(OptionsWithEquality(), OptionsWithEquality());
    });
  });
}
