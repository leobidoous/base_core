import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' show GlobalKey;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
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
    double pixelRatio = 1.0,
  }) async {
    try {
      final files = List.empty(growable: true);
      for (var key in keys) {
        try {
          final boundary =
              key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: pixelRatio);
          final byteData =
              await image.toByteData(format: ui.ImageByteFormat.png);
          final pngBytes = byteData!.buffer.asUint8List();

          // Get directory to save the file
          final directory = await getApplicationDocumentsDirectory();
          final filePath = '${directory.path}/temp_image_${key.hashCode}.png';
          final file = File(filePath);

          // Save the file
          await file.writeAsBytes(pngBytes);
          files.add(file);
        } catch (e) {
          debugPrint('ShareDriver.shareWidgets error: $e');
        }
      }
      await Share.shareXFiles(files.map((f) => XFile(f.path)).toList());
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
