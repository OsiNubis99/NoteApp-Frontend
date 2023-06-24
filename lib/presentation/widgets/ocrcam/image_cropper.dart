import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../config/theme/app_theme.dart';

Future<String> imageCropper(String? path, BuildContext context) async {

  CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path!,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cortar imagen',
            toolbarColor: AppTheme.bgGray,
            toolbarWidgetColor: AppTheme.primary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cortar imagen',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      return croppedFile.path;
    } else {
      return '';
    }

}

