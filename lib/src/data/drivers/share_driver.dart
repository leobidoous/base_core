import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' show BuildContext, GlobalKey;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_share_driver.dart';

class ShareDriver extends IShareDriver {
  SharePlus get instance => SharePlus.instance;

  @override
  Future<Either<Exception, Unit>> shareFiles({
    required BuildContext context,
    required List<XFile> files,
    String? subject,
    String? text,
  }) async {
    try {
      final box = context.findRenderObject() as RenderBox;
      await instance.share(
        ShareParams(
          files: files,
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        ),
      );
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> shareWidgets({
    required BuildContext context,
    required List<GlobalKey> keys,
    double pixelRatio = 1.0,
    String? subject,
    String? text,
  }) async {
    try {
      final box = context.findRenderObject() as RenderBox;
      final files = <XFile>[];
      for (var key in keys) {
        try {
          final boundary =
              key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: pixelRatio);
          final byteData = await image.toByteData(
            format: ui.ImageByteFormat.png,
          );
          final pngBytes = byteData!.buffer.asUint8List();

          // Get directory to save the file
          final directory = await getTemporaryDirectory();
          final fileName = 'comprovante_${key.hashCode}.png';
          final file = File('${directory.path}/$fileName');

          // Save the file
          await file.writeAsBytes(pngBytes, flush: true);
          files.add(XFile(file.path, name: fileName, mimeType: 'image/png'));
        } catch (e) {
          debugPrint('ShareDriver.shareWidgets error: $e');
        }
      }
      if (files.isEmpty) {
        return Left(Exception('Nenhuma imagem foi gerada para compartilhar.'));
      }
      await instance.share(
        ShareParams(
          files: files,
          subject: subject,
          text: text,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        ),
      );
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> shareText({
    required BuildContext context,
    required String text,
    String? subject,
  }) async {
    try {
      final box = context.findRenderObject() as RenderBox;
      await instance.share(
        ShareParams(
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
        ),
      );
      return Right(unit);
    } catch (e, s) {
      return Left(Exception('$e $s'));
    }
  }
}
