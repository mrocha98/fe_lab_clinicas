import 'package:equatable/equatable.dart';
import 'package:fe_lab_clinicas_core/src/fp/nil.dart';
import 'package:fe_lab_clinicas_core/src/fp/unit.dart';
import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:meta/meta.dart';

@immutable
sealed class Either<L, R> extends Equatable {
  const Either(this.value);

  final dynamic value;

  @override
  List<Object?> get props => [value];

  L get left => value as L;

  R get right => value as R;

  bool get isLeft => value is L;

  bool get isRight => value is R;

  void on({
    VoidCallback? left,
    VoidCallback? right,
  }) {
    switch (value) {
      case L():
        left?.call();
      case R():
        right?.call();
    }
  }
}

final class Left<L, R> extends Either<L, R> {
  const Left(L super.value);

  static Left<Unit, R> unit<R>() => const Left(Unit());

  static Left<Nil, R> nil<R>() => const Left(Nil());
}

final class Right<L, R> extends Either<L, R> {
  const Right(R super.value);

  static Right<L, Unit> unit<L>() => const Right(Unit());

  static Right<L, Nil> nil<L>() => const Right(Nil());
}
