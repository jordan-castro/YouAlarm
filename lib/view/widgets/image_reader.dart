import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youalarm/view/widgets/loading_widget.dart';

class ImageReader extends StatelessWidget {
  final String? imageSource;
  final bool? searchFile;
  final bool? fromNetwork;
  final double? height;
  final double? width;
  final String? errorImage;
  final Widget? errorWidget;
  final BoxFit? fit;

  const ImageReader({
    Key? key,
    this.imageSource,
    this.searchFile,
    this.fromNetwork,
    this.height,
    this.width,
    this.errorImage,
    this.errorWidget,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageWidget();
  }

  Widget imageWidget() {
    // Chequea si imagesource es null
    if (imageSource == null) {
      // There was an error
      return buildErrorWidget();
    } else {
      if (fromNetwork == true) {
        return network();
      } else if (searchFile == true) {
        return fromFile();
      } else {
        // Assuma network
        return network();
      }
    }
  }

  Widget network() {
    return CachedNetworkImage(
      imageUrl: imageSource!,
      height: height,
      width: width,
      fit: fit,
      errorWidget: (context, erorr, _) => buildErrorWidget(),
      placeholder: (context, _) => buildPlaceHolder(),
    );
  }

  Widget fromFile() {
    File file = File(imageSource!);
    if (file.existsSync()) {
      return Image.file(
        file,
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return buildErrorWidget();
    }
  }

  Widget buildErrorWidget() {
    if (errorImage != null) {
      return Image.asset(
        errorImage!,
        width: width,
        fit: fit,
        height: height,
      );
    } else {
      // Chequea si errorWidget esta alli
      if (errorWidget != null) {
        return errorWidget!;
      }
      // Default
      return Image.asset(
        "assets/images/appicon.png",
        width: width,
        fit: fit,
        height: height,
      );
    }
  }

  Widget buildPlaceHolder() {
    return SizedBox(
      height: height,
      width: width,
      child: const LoadingWidget(),
    );
  }
}

/// Igual a `ImageReader()` solo con circulo.
class CircleImageReader extends StatelessWidget {
  final String? imageSource;
  final bool? isAsset;
  final double? circumfrance;
  final String? errorImage;
  final BoxFit? fit;
  final double? height;
  final double? width;

  const CircleImageReader({
    Key? key,
    this.imageSource,
    this.isAsset,
    this.circumfrance,
    this.errorImage,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);

  static const FAILURE = "assets/images/failure.png";

  @override
  Widget build(BuildContext context) {
    if (isAsset == true) {
      return CircleAvatar(
        radius: circumfrance,
        backgroundImage: Image.asset(
          imageSource ?? errorImage ?? FAILURE,
          fit: fit,
          height: height,
          width: width,
        ).image,
      );
    }

    // Chequea por null
    if (imageSource == null || imageSource?.trim().length == 0) {
      assert(errorImage != null);
      return CircleImageReader(
        circumfrance: circumfrance,
        isAsset: true,
        imageSource: errorImage,
        width: width,
        height: height,
        fit: fit,
      );
    }

    // Assuma web
    return CachedNetworkImage(
      imageUrl: imageSource!,
      height: height,
      width: width,
      fit: fit,
      errorWidget: (context, error, _) {
        return CircleImageReader(
          circumfrance: circumfrance,
          isAsset: true,
          imageSource: errorImage ?? FAILURE,
          width: width,
          height: height,
          fit: fit,
        );
      },
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: circumfrance,
          backgroundImage: imageProvider,
        );
      },
      placeholder: (context, _) {
        return SizedBox(
          height: height,
          width: width,
          child: const LoadingWidget(),
        );
      },
    );
  }
}

// /// Controls the creation of the `User`'s `user.image` for the `UserScreen`.
// class UserImage extends StatelessWidget {
//   /// Add a custom radius otherwise 50.0
//   final double? customRadius;

//   const UserImage({Key? key, this.customRadius}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Busca el imagen
//     final image = Provider.of<UserModel>(context).user.imageSource ?? "";

//     var imageWidget;
//     // Checking if image is empty
//     if (image.length == 0) {
//       imageWidget = Image.asset("assets/images/blankprofile.jpg");
//     } else {
//       imageWidget = ImageReader(
//         imageSource: image,
//         errorImage: "assets/images/blankprofile.jpg",
//         fit: BoxFit.fill,
//       );
//     }

//     return Container(
//       height: 200.0,
//       child: AspectRatio(
//         aspectRatio: (10 / 12.5),
//         child: CircleImageReader(
//           imageSource: image,
//           errorImage: "assets/images/blankprofile.jpg",
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
