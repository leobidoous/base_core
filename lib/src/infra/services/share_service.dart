import 'package:flutter/material.dart' show GlobalKey, BuildContext;
import 'package:share_plus/share_plus.dart' show XFile;

import '../../domain/interfaces/either.dart';
import '../../domain/services/i_share_service.dart';
import '../drivers/i_share_driver.dart';

class ShareService extends IShareService {
  ShareService({required this.shareDriver});

  final IShareDriver shareDriver;

  @override
  Future<Either<Exception, Unit>> shareFiles({
    required BuildContext context,
    required List<XFile> files,
    String? subject,
    String? text,
  }) {
    return shareDriver.shareFiles(
      context: context,
      subject: subject,
      files: files,
      text: text,
    );
  }

  @override
  Future<Either<Exception, Unit>> shareWidgets({
    required BuildContext context,
    required List<GlobalKey> keys,
    double pixelRatio = 1.0,
    String? subject,
    String? text,
  }) {
    return shareDriver.shareWidgets(
      keys: keys,
      context: context,
      pixelRatio: pixelRatio,
      subject: subject,
      text: text,
    );
  }

  @override
  Future<Either<Exception, Unit>> shareText({
    required BuildContext context,
    required String text,
    String? subject,
  }) async {
    if (text.isEmpty) return Left(Exception('Texto não pode ser vazio.'));
    return shareDriver.shareText(
      text: text,
      subject: subject,
      context: context,
    );
  }
}
