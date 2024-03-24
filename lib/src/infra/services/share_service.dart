import 'dart:io';

import 'package:flutter/material.dart' show GlobalKey;

import '../../domain/interfaces/either.dart';
import '../../domain/services/i_share_service.dart';
import '../drivers/i_share_driver.dart';

class ShareService extends IShareService {
  ShareService({required this.shareDriver});

  final IShareDriver shareDriver;

  @override
  Future<Either<Exception, Unit>> shareFiles({required List<File> files}) {
    return shareDriver.shareFiles(files: files);
  }

  @override
  Future<Either<Exception, Unit>> shareWidgets({
    required List<GlobalKey> keys,
  }) {
    return shareDriver.shareWidgets(keys: keys);
  }

  @override
  Future<Either<Exception, Unit>> shareText({required String text}) {
    return shareDriver.shareText(text: text);
  }
}
