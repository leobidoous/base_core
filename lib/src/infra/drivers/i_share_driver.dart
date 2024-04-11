import 'dart:io';

import 'package:flutter/widgets.dart';

import '../../domain/interfaces/either.dart';

abstract class IShareDriver {
  Future<Either<Exception, Unit>> shareText({required String text});
  Future<Either<Exception, Unit>> shareFiles({required List<File> files});
  Future<Either<Exception, Unit>> shareWidgets({required List<GlobalKey> keys});
}
