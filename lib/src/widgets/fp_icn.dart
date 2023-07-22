import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum FpIconType { svg, png }

class _FpIcnLoader {
  _FpIcnLoader.asset({
    required String assetName,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.fpIconType = FpIconType.svg,
    this.padding,
  }) {
    _assetName = assetName;
  }

  _FpIcnLoader.memory({
    required Uint8List bytes,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.fpIconType = FpIconType.svg,
    this.padding,
  }) {
    _bytes = bytes;
  }

  String? _assetName;
  Uint8List? _bytes;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final Function? onTap;
  final FpIconType fpIconType;
  final EdgeInsetsGeometry? padding;

  Widget _getFromAsset() {
    return fpIconType == FpIconType.svg
        ? SvgPicture.asset(
            _assetName!,
            fit: fit ?? BoxFit.none,
            // ignore: deprecated_member_use
            color: color,
            width: width,
            height: height,
          )
        : Image.asset(
            _assetName!,
            filterQuality: FilterQuality.high,
          );
  }

  Widget _getFromMemory() {
    return fpIconType == FpIconType.svg
        ? SvgPicture.memory(
            _bytes!,
            fit: fit ?? BoxFit.none,
            // ignore: deprecated_member_use
            color: color,
            width: width,
            height: height,
          )
        : Image.memory(
            _bytes!,
            filterQuality: FilterQuality.high,
          );
  }

  Widget getWidget() {
    return SizedBox(
      width: width,
      height: height,
      child: _assetName != null ? _getFromAsset() : _getFromMemory(),
    );
  }
}

class FpIcn extends StatelessWidget {
  FpIcn.asset({
    super.key,
    required String assetName,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.fpIconType = FpIconType.svg,
    this.padding,
  }) : _fpIcnLoader = _FpIcnLoader.asset(
          assetName: assetName,
          color: color,
          fit: fit,
          fpIconType: fpIconType,
          height: height,
          onTap: onTap,
          padding: padding,
          width: width,
        );

  FpIcn.memory({
    super.key,
    required Uint8List bytes,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.fpIconType = FpIconType.svg,
    this.padding,
  }) : _fpIcnLoader = _FpIcnLoader.memory(
          bytes: bytes,
          color: color,
          fit: fit,
          fpIconType: fpIconType,
          height: height,
          onTap: onTap,
          padding: padding,
          width: width,
        );

  final _FpIcnLoader _fpIcnLoader;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final Function? onTap;
  final FpIconType fpIconType;
  final EdgeInsetsGeometry? padding;

  FpIcn copyWith({Color? color}) {
    return _fpIcnLoader._assetName != null
        ? FpIcn.asset(
            fpIconType: fpIconType,
            color: color ?? this.color,
            fit: fit,
            height: height,
            assetName: _fpIcnLoader._assetName!,
            onTap: onTap,
            width: width,
            padding: padding,
          )
        : FpIcn.memory(
            fpIconType: fpIconType,
            color: color ?? this.color,
            fit: fit,
            height: height,
            bytes: _fpIcnLoader._bytes!,
            onTap: onTap,
            width: width,
            padding: padding,
          );
  }

  @override
  Widget build(BuildContext context) {
    return _fpIcnLoader.getWidget();
  }
}
