
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class NoInternet {
//   static Widget buildBody({required Widget child}) {
//     return Column(
//       children: [
//         buildConnectInternet(),
//         Expanded(
//           child: child,
//         ),
//       ],
//     );
//   }

//   static Widget buildConnectInternet() {
//     RxBool hide = false.obs;
//     return Obx(
//       () => Visibility(
//         visible: isOffline.value,
//         child: Container(
//           color: showOnline.value ? Colors.green.shade50 : Colors.red.shade50,
//           child: Column(
//             children: [
//               showOnline.value
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.wifi,
//                               color: Colors.green,
//                             ),
//                             UtilWidget.sizedBoxWidth10,
//                             Text(
//                               AppStr.messageOnline,
//                               style: Get.textTheme.bodyText2!.copyWith(
//                                 color: Colors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.done,
//                             color: Colors.green,
//                             size: 28,
//                           ),
//                         )
//                       ],
//                     ).paddingSymmetric(
//                       horizontal: AppDimens.paddingVerySmall,
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.signal_wifi_bad_outlined,
//                               color: Colors.red,
//                             ),
//                             UtilWidget.sizedBoxWidth10,
//                             Text(
//                               AppStr.messageUseNoInternet,
//                               style: Get.textTheme.bodyText2!.copyWith(
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             hide.value = !hide.value;
//                           },
//                           icon: Icon(
//                             hide.value ? Icons.expand_less : Icons.expand_more,
//                             color: Colors.red,
//                             size: 28,
//                           ),
//                         )
//                       ],
//                     ).paddingSymmetric(
//                       horizontal: AppDimens.paddingVerySmall,
//                     ),
//               Visibility(
//                 visible: hide.value,
//                 child: Column(
//                   children: [
//                     UtilWidget.iconBeforeText(
//                       icon: Icons.noise_control_off,
//                       iconSize: 10,
//                       padding: EdgeInsets.all(3),
//                       title: AppStr.messageUseCreateProduct,
//                     ),
//                     UtilWidget.sizedBox10,
//                     UtilWidget.iconBeforeText(
//                       icon: Icons.noise_control_off,
//                       iconSize: 10,
//                       padding: EdgeInsets.all(3),
//                       title: AppStr.messagePleaseConnectToInternet,
//                     ),
//                     UtilWidget.sizedBox10,
//                     UtilWidget.sizedBox10,
//                   ],
//                 ).paddingSymmetric(
//                   horizontal: AppDimens.paddingHuge,
//                 ),
//               ),
//             ],
//           ).paddingOnly(
//             left: AppDimens.paddingSmall,
//           ),
//         ),
//       ),
//     );
//   }

//   static Widget buildDialogNoInternet() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.textColorWhite,
//         borderRadius: BorderRadius.all(
//           Radius.circular(AppDimens.paddingVerySmall),
//         ),
//       ),
//       width: Get.width,
//       height: Get.height / 1.5,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   ImageAsset.imgDisconnect,
//                   height: AppDimens.btnMedium * 2.5,
//                 ).paddingSymmetric(vertical: AppDimens.paddingMedium),
//                 buildText(
//                   AppStr.messageUseNoInternet,
//                   fontWeight: FontWeight.bold,
//                   fontSize: AppDimens.fontBig(),
//                 ),
//                 buildText(
//                   AppStr.modeNoInternetRecommend,
//                 ).paddingSymmetric(vertical: AppDimens.paddingMedium),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: UtilWidget.buildButtonWithBorder(
//                   AppStr.backButton,
//                   () {
//                     Get.back();
//                   },
//                   padding: AppDimens.paddingItemList,
//                 ).paddingSymmetric(
//                   horizontal: AppDimens.paddingVerySmall,
//                 ),
//               ),
//               Expanded(
//                 child: UtilWidget.buildButton(
//                   AppStr.createBill,
//                   () {
//                     Get.offAndToNamed(AppRoutes.routeCreateOrderOffline);
//                   },
//                   backgroundColor: AppColors.lightPrimaryColor,
//                   fontSize: AppDimens.fontSmall(),
//                 ).paddingOnly(
//                   right: AppDimens.paddingVerySmall,
//                 ),
//               ),
//             ],
//           ).paddingAll(AppDimens.paddingVerySmall),
//         ],
//       ),
//     );
//   }

//   static Widget buildText(
//     String text, {
//     FontWeight? fontWeight,
//     double? fontSize,
//     Color? colorText,
//   }) {
//     return Text(
//       text,
//       style: Get.textTheme.bodyText2!.copyWith(
//         color: colorText ?? AppColors.textColor(),
//         fontWeight: fontWeight,
//         fontSize: fontSize,
//       ),
//       textAlign: TextAlign.center,
//     );
//   }
// }
