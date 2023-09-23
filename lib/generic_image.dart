library generic_image;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum ImageFormat { svg, png, jpg, network, detectAutomatically }

/// The `SvgStyle` class represents the style properties for an SVG element in Dart.
class SvgStyle {
  final Color? color;
  final BlendMode colorBlendMode;
  final String? package;
  final bool allowDrawingOutsideViewBox;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final AlignmentGeometry alignment;
  final bool matchTextDirection;
  final Clip? clipBehavior;

  SvgStyle({
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.package,
    this.allowDrawingOutsideViewBox = false,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.clipBehavior,
  });
}

/// A customizable image widget that supports various image formats, including SVG, PNG, and JPEG.
///
/// This widget provides options for loading images from various sources, such as assets or network URLs,
/// and supports placeholders and error widgets for a better user experience.
class GenericImage extends StatelessWidget {
  final String src;
  final ImageFormat format;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final SvgStyle? svgStyle;
  final bool enableNetworkImageCaching;

  /// Creates a new instance of [GenericImage].
  ///
  /// The [src] parameter is required and should specify the image source.
  /// You can provide [format] to explicitly specify the image format, or it will be detected automatically.
  /// You can also set the [width], [height], [fit], [placeholder], [errorWidget], and [svgStyle] as per your requirements.
  const GenericImage({
    super.key,
    required this.src,
    this.format = ImageFormat.detectAutomatically,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.svgStyle,
    this.enableNetworkImageCaching = true,
  });

  ImageFormat _detectImageFormat() {
    if (src.endsWith('.svg')) {
      return ImageFormat.svg;
    } else if (src.endsWith('.png')) {
      return ImageFormat.png;
    } else if (src.endsWith('.jpg') || src.endsWith('.jpeg')) {
      return ImageFormat.jpg;
    } else {
      return ImageFormat.detectAutomatically;
    }
  }

  bool _isNetworkImage() {
    return src.startsWith('http://') || src.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final resolvedFormat = format == ImageFormat.detectAutomatically
        ? _detectImageFormat()
        : format;
    final isNetworkImage = _isNetworkImage();

    placeholderBuilder(BuildContext context) {
      if (placeholder != null) {
        return placeholder!(context, src);
      }
      return const SizedBox();
    }

    switch (resolvedFormat) {
      case ImageFormat.svg:
        return SvgPicture.asset(
          src,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: placeholderBuilder,
          clipBehavior: svgStyle?.clipBehavior ?? Clip.hardEdge,
          colorBlendMode: svgStyle?.colorBlendMode ?? BlendMode.srcIn,
          package: svgStyle?.package,
          allowDrawingOutsideViewBox:
              svgStyle?.allowDrawingOutsideViewBox ?? false,
          semanticsLabel: svgStyle?.semanticsLabel,
          excludeFromSemantics: svgStyle?.excludeFromSemantics ?? false,
          color: svgStyle?.color,
          alignment: svgStyle?.alignment ?? Alignment.center,
          matchTextDirection: svgStyle?.matchTextDirection ?? false,
        );
      case ImageFormat.png:
      case ImageFormat.jpg:
        if (isNetworkImage) {
          return CachedNetworkImage(
            imageUrl: src,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => placeholderBuilder(context),
            errorWidget: (context, url, error) {
              if (errorWidget != null) {
                return errorWidget!(context, src, error);
              }
              return const Icon(Icons.error);
            },
          );
        } else {
          return Image.asset(
            src,
            width: width,
            height: height,
            fit: fit,
          );
        }
      case ImageFormat.network:
        if (isNetworkImage) {
          return CachedNetworkImage(
            imageUrl: src,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => placeholderBuilder(context),
            errorWidget: (context, url, error) {
              if (errorWidget != null) {
                return errorWidget!(context, src, error);
              }
              return const Icon(Icons.error);
            },
          );
        } else {
          return const SizedBox(); // Handle the case where the format is not recognized.
        }
      case ImageFormat.detectAutomatically:
        if (resolvedFormat == ImageFormat.svg) {
          return SvgPicture.asset(
            src,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: placeholderBuilder,
            clipBehavior: svgStyle?.clipBehavior ?? Clip.hardEdge,
            colorBlendMode: svgStyle?.colorBlendMode ?? BlendMode.srcIn,
            package: svgStyle?.package,
            allowDrawingOutsideViewBox:
                svgStyle?.allowDrawingOutsideViewBox ?? false,
            semanticsLabel: svgStyle?.semanticsLabel,
            excludeFromSemantics: svgStyle?.excludeFromSemantics ?? false,
            color: svgStyle?.color,
            alignment: svgStyle?.alignment ?? Alignment.center,
            matchTextDirection: svgStyle?.matchTextDirection ?? false,
          );
        } else if (isNetworkImage) {
          return CachedNetworkImage(
            imageUrl: src,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => placeholderBuilder(context),
            errorWidget: (context, url, error) {
              if (errorWidget != null) {
                return errorWidget!(context, src, error);
              }
              return const Icon(Icons.error);
            },
          );
        } else {
          return Image.asset(
            src,
            width: width,
            height: height,
            fit: fit,
          );
        }
      default:
        return const SizedBox(); // Default to an empty container if the format is not recognized.
    }
  }
}
