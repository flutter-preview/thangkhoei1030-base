import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/theme/boxShadows.dart';
import 'package:flutter_application_3/core/utils/widget/utils_widget.dart';
import 'package:get/get.dart';

import '../../../values/dimens.dart';

class CardUtils {
  static Widget buildCardCustomRadiusBorder({
    double? radiusTopRight,
    double? radiusTopLeft,
    double? radiusBottomRight,
    double? radiusBottomLeft,
    required Widget child,
    double? radiusAll,
    double spreadRadius = 2.5,
    double blurRadius = 10,
    List<BoxShadow>? boxShadows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radiusAll ?? radiusBottomRight ?? 0),
          bottomLeft: Radius.circular(radiusAll ?? radiusBottomLeft ?? 0),
          topLeft: Radius.circular(radiusAll ?? radiusTopLeft ?? 0),
          topRight: Radius.circular(radiusAll ?? radiusTopRight ?? 0),
        ),
        boxShadow: boxShadows,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radiusAll ?? radiusBottomRight ?? 0),
          bottomLeft: Radius.circular(radiusAll ?? radiusBottomLeft ?? 0),
          topLeft: Radius.circular(radiusAll ?? radiusTopLeft ?? 0),
          topRight: Radius.circular(radiusAll ?? radiusTopRight ?? 0),
        ),
        child: child,
      ),
    );
  }

  static Widget buildContentInCard({
    required String url,
    required Widget cardInfo,
    double? heightImage,
    double? widthImage,
  }) {
    return Column(
      children: [
        Expanded(
          child: UtilWidget.buildImageWidget(
            url,
            heightImage: heightImage,
            widthImage: widthImage ?? double.infinity,
          ),
        ),
        // Container(
        //   height: heightImage ?? 200,
        //   width: widthImage ?? double.infinity,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.cover,
        //       image: NetworkImage(url),
        //     ),
        //   ),
        // ),
        cardInfo.paddingSymmetric(
            horizontal: AppDimens.paddingSmall,
            vertical: AppDimens.paddingSmall)
      ],
    );
  }

  // static Widget buildItemsBGImgStack(
  //     {String? urlImages, double? height, double? width}) {
  //   return Stack(
  //     children: [
  //       if (urlImages != null)
  //         Image.network(
  //           urlImages,
  //           height: height,
  //           width: width ?? double.infinity,
  //         ),
  //         buildColumnDescriptions()
  //     ],
  //   );
  // }
}
