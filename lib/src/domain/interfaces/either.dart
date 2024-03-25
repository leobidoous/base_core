abstract class Either<TLeft, TRight> {
  const Either();

  bool get isLeft;
  bool get isRight;

  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn);

  TRight getOrElse(TRight Function(TLeft left) orElse);

  Either<TLeft, T> bind<T>(Either<TLeft, T> Function(TRight r) fn) {
    return fold(Left, fn);
  }

  Future<Either<TLeft, T>> asyncBind<T>(
    Future<Either<TLeft, T>> Function(TRight r) fn,
  ) {
    return fold((l) async => Left(l), fn);
  }

  Either<T, TRight> leftBind<T>(Either<T, TRight> Function(TLeft l) fn) {
    return fold(fn, Right);
  }

  Either<TLeft, T> map<T>(T Function(TRight r) fn) {
    return fold(Left, (r) => Right(fn(r)));
  }

  Either<T, TRight> leftMap<T>(T Function(TLeft l) fn) {
    return fold((l) => Left(fn(l)), Right);
  }
}

class _Left<TLeft, TRight> extends Either<TLeft, TRight> {
  _Left(this._value);
  final TLeft _value;

  @override
  final bool isLeft = true;

  @override
  final bool isRight = false;

  @override
  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn) {
    return leftFn(_value);
  }

  @override
  TRight getOrElse(TRight Function(TLeft l) orElse) {
    return orElse(_value);
  }
}

class _Right<TLeft, TRight> extends Either<TLeft, TRight> {
  _Right(this._value);
  final TRight _value;

  @override
  final bool isLeft = false;

  @override
  final bool isRight = true;

  @override
  T fold<T>(T Function(TLeft l) leftFn, T Function(TRight r) rightFn) {
    return rightFn(_value);
  }

  @override
  TRight getOrElse(TRight Function(TLeft l) orElse) {
    return _value;
  }
}

// ignore: non_constant_identifier_names
Either<TLeft, TRight> Right<TLeft, TRight>(TRight r) =>
    _Right<TLeft, TRight>(r);
// ignore: non_constant_identifier_names
Either<TLeft, TRight> Left<TLeft, TRight>(TLeft l) => _Left<TLeft, TRight>(l);

abstract class Unit {}

class _Unit implements Unit {
  const _Unit();
}

const unit = _Unit();
