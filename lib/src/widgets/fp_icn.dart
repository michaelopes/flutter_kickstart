import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum FpIconType { svg, png }

class FpIcn extends StatelessWidget {
  const FpIcn({
    this.icon,
    Key? key,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.fpIconType = FpIconType.svg,
    this.padding,
  }) : super(key: key);

  final String? icon;
  final BoxFit? fit;
  final Color? color;
  final double? height;
  final double? width;
  final Function? onTap;
  final FpIconType fpIconType;
  final EdgeInsetsGeometry? padding;

  FpIcn copyWith({Color? color}) {
    return FpIcn(
      fpIconType: fpIconType,
      color: color ?? this.color,
      fit: fit,
      height: height,
      icon: icon,
      key: key,
      onTap: onTap,
      width: width,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: fpIconType == FpIconType.svg
          ? SvgPicture.asset(
              icon ?? "",
              fit: fit ?? BoxFit.none,
              // ignore: deprecated_member_use
              color: color,
              width: width,
              height: height,
            )
          : Image.asset(
              icon!,
              filterQuality: FilterQuality.high,
            ),
    );
  }
}
