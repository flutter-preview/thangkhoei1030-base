import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/widget/base_widget/page.dart';
import 'package:flutter_application_3/core/utils/widget/const_widget.dart';
import 'package:get/get.dart';

import '../../core/utils/widget/utils_widget.dart';
import '../controller/base_controller.dart';

abstract class BaseGetWidget<T extends BaseGetxController> extends GetView<T> {
  const BaseGetWidget({Key? key}) : super(key: key);

  Widget buildWidgets();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // tắt tính năng vuốt trái để back lại màn hình trước đó trên iphone
      onWillPop: () async {
        // KeyBoard.hide();
        // await 300.milliseconds.delay();
        return !Navigator.of(context).userGestureInProgress;
      },
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: buildWidgets()),
    );
  }

  Widget baseShowLoading(WidgetCallback child) {
    return Obx(
      () => controller.isShowLoading.value
          ? const Scaffold(
              body: Center(
                child: WidgetConst.buildLoading,
              ),
            )
          : child(),
    );
  }

  Widget baseShimmerLoading(WidgetCallback child, {Widget? shimmer}) {
    return Obx(
      () => controller.isShowLoading.value
          ? shimmer ?? PageUtils.buildShimmerLoading()
          : child(),
    );
  }

  // Widget buildLoadingOverlay(WidgetCallback child) {
  //   return Obx(
  //     () => Stack(
  //       children: [
  //         LoadingOverlayPro(
  //           progressIndicator: !GetPlatform.isMobile
  //               ? const CupertinoActivityIndicator(
  //                   radius: 50,
  //                 )
  //               : UtilWidget.buildLoading,
  //           isLoading: controller.isLoadingOverlay.value,
  //           child: child(),
  //         ),
  //         if (controller.isIssueSuccess.value)
  //           Stack(
  //             children: [
  //               Container(
  //                 color: Colors.black38,
  //               ),
  //               Center(
  //                 child: SlitInVertical(
  //                   preferences: AnimationPreferences(
  //                     autoPlay: AnimationPlayStates.Forward,
  //                     duration: 500.milliseconds,
  //                   ),
  //                   child: Icon(
  //                     Icons.check_circle,
  //                     color: Colors.lightGreenAccent,
  //                     size: Get.width / 5,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //       ],
  //     ),
  //   );
  // }
  //TODO: BodyOffline
  // Widget buildBodyOffline() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Image.asset(
  //         ImageAsset.imgNoInternet,
  //         height: AppDimens.sizeAppBar,
  //         width: AppDimens.sizeAppBar,
  //       ),
  //       SizedBox(
  //         height: AppDimens.sizeIcon,
  //       ),
  //       Text(
  //         AppStr.noInternet.tr,
  //         style: TextStyle(
  //             fontSize: AppDimens.sizeIcon, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(
  //         height: AppDimens.sizeIcon,
  //       ),
  //       Text(
  //         AppStr.noInternetMsg.tr,
  //         style: TextStyle(
  //           fontSize: AppDimens.paddingItemList,
  //         ),
  //         textAlign: TextAlign.center,
  //       ).paddingSymmetric(horizontal: AppDimens.sizeIcon),
  //       SizedBox(
  //         height: AppDimens.sizeIcon,
  //       ),
  //       UtilWidget.buildButton(
  //         AppStr.createBill.tr,
  //         () {
  //           Get.to(() => CreateBillOfflinePage());
  //         },
  //         height: AppDimens.sizeDialogNotiIcon,
  //         width: Get.width / 3,
  //       )
  //     ],
  //   );
  // }
}
