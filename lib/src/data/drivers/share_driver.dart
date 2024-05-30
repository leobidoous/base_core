import 'dart:io';

import 'package:flutter/material.dart' show GlobalKey;
import 'package:share_plus/share_plus.dart';

import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_share_driver.dart';

class ShareDriver extends IShareDriver {
  @override
  Future<Either<Exception, Unit>> shareFiles({
    required List<File> files,
  }) async {
    try {
      await Share.shareXFiles(files.map((f) => XFile(f.path)).toList());
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> shareWidgets({
    required List<GlobalKey> keys,
  }) async {
    try {
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> shareText({required String text}) async {
    try {
      await Share.share(text);
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }
}
