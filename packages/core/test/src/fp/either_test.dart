import 'package:fe_lab_clinicas_core/src/fp/fp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Either', () {
    test('should implement equality', () {
      const Either<int, int> a = Left(1);
      const Either<int, int> b = Left(1);
      const Either<int, int> c = Left(2);
      const Either<int, int> d = Right(1);

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a, isNot(equals(d)));
    });

    test('.left should return value as L', () {
      const Either<int, String> either = Left(1);
      final left = either.left;
      expect(left, 1);
    });

    test('.right should return value as R', () {
      const Either<int, String> either = Right('a');
      final right = either.right;
      expect(right, 'a');
    });

    group('.isLeft', () {});

    group('.isRight', () {});

    group('.on', () {});

    group('Right', () {});

    group('Left', () {});
  });
}
