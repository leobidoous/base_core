import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart' show XFile;

import '../../domain/interfaces/either.dart';

abstract class IShareDriver {
  Future<Either<Exception, Unit>> shareText({
    required String text,
    String? subject,
  });
  Future<Either<Exception, Unit>> shareFiles({
    required List<XFile> files,
    String? subject,
    String? text,
  });
  Future<Either<Exception, Unit>> shareWidgets({
    required List<GlobalKey> keys,
    double pixelRatio = 1.0,
    String? subject,
    String? text,
  });
}
