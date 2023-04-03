part of 'test_screen.dart';

Widget _buildHotelsPage(TestController controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar('Hotels',
        textStyle: Get.textTheme.titleLarge!
            .copyWith(shadows: BoxShadowsConst.shadowText),
        isLeading: false,
        actions: [
          const Icon(
            Icons.search,
            color: Colors.black,
          )
        ]),
    body: SingleChildScrollView(
      child: Column(
        children: [
          CardUtils.buildCardCustomRadiusBorder(
            radiusAll: AppDimens.radius25,
            boxShadows: BoxShadowsConst.shadowCard,
            child: Container(
              color: Colors.black,
              width: Get.width,
              child: UtilWidget.buildInput(
                controller.searchCtr,
                borderRadius: AppDimens.radius25,
                iconLeading: Icons.search,
                hintText: 'Where to go?',
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ).paddingSymmetric(horizontal: AppDimens.defaultPadding),
          _buildBodyHotels(controller),
        ],
      ),
    ),
  );
}

Widget _buildBodyHotels(TestController controller) {
  return Column(
    children: [
      UtilWidget.buildLiStScrollWithTitle(
        leading: UtilWidget.buildTitle(text: "Near You"),
        itemsCount: 10,
        itemsWidget: (index) => _buildNearYou(),
        separatorWidget: WidgetConst.sizedBoxWidth10,
        scrollDirection: Axis.horizontal,
        height: 100,
        isScroll: true,
        actionWidget: UtilButton.buildTextButton(
            title: 'Show All',
            isUnderLineText: true,
            colorText: AppColors.backGroundColorButtonDefault),
      ),
      _buildPopularOffer(controller),
      _buildTopHotels(),
    ],
  ).paddingSymmetric(
    horizontal: AppDimens.paddingVerySmall,
    vertical: AppDimens.defaultPadding,
  );
}

Widget _buildNearYou() {
  return Stack(
    children: [
      UtilWidget.buildImageWidget(
        'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
        heightImage: 75,
        widthImage: 95,
      ),
      Positioned(
          top: 75 * 2 / 3,
          left: AppDimens.paddingVerySmall,
          child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Text(
                'hotels',
                style: Get.textTheme.bodyText1!
                    .copyWith(color: Colors.white, fontSize: 8),
              ))),
    ],
  );
}

Widget _buildPopularOffer(TestController controller) {
  return UtilWidget.buildLiStScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Popular Offer'),
    itemsCount: 5,
    itemsWidget: (index) => _buildItemPopularOffer(),
    separatorWidget: WidgetConst.sizedBoxWidth10,
    scrollDirection: Axis.horizontal,
    isScroll: true,
    height: 100,
  );
  // return UtilWidget.buildLiStScrollWithTitle(

  //   child: UtilWidget.buildSlideTransition<TestController>(
  //     child: (index, _) => _buildItemPopularOffer().marginSymmetric(vertical: AppDimens.paddingVerySmall),
  //     itemsCount: 5,
  //     currentIndexPosition: controller.currentPageScroll,
  //     isUsingDotIndicator: false,
  //     heightScroll: 100,
  //     viewportFraction: 0.9
  //   ),
  // );
}

Widget _buildItemPopularOffer() {
  return Column(
    children: [
      CardUtils.buildCardCustomRadiusBorder(
        boxShadows: BoxShadowsConst.shadowCard,
        radiusAll: AppDimens.radiusCard,
        child: SizedBox(
          width: Get.width - AppDimens.paddingLarge * 2,
          child: UtilWidget.itemLine(
            urlImages:
                'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
            heightImagesLeading: 69,
            widthImageLeading: 69,
            title: AutoSizeText(
              'Sel de Mer Hotel & Suites',
              style: Get.textTheme.bodyText1,
            ),
            subtitle:
                AutoSizeText(r'From $345', style: Get.textTheme.bodySmall),
            trailing: UtilWidget.buildAction(
              text: 4.7.toString(),
              spaceAround: AppDimens.paddingSmallest,
              textStyle: Get.textTheme.bodyText1!
                  .copyWith(fontSize: AppDimens.sizeTextSmall),
              iconData: Icons.star,
              iconSize: AppDimens.sizeIconVerySmall,
              colorIcon: AppColors.backGroundColorButtonDefault,
            ),
          ),
        ),
      ),
      WidgetConst.sizedBox10,
    ],
  );
}

Widget _buildTopHotels() {
  return UtilWidget.buildLiStScrollWithTitle(
    leading: Row(
      children: [
        UtilWidget.buildTitle(text: 'Top Hotels'),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusDefault)),
          color: AppColors.backGroundColorButtonDefault,
          child: AutoSizeText(
            'HOT',
            style: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
          ).paddingSymmetric(
            horizontal: AppDimens.paddingVerySmall,
            vertical: AppDimens.paddingSmallest,
          ),
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
      ],
    ),
    height: 100,
    itemsCount: 5,
    itemsWidget: (index) => _buildNearYou(),
    scrollDirection: Axis.horizontal,
    separatorWidget: WidgetConst.sizedBoxWidth10,
    isScroll: true,
    actionWidget: UtilButton.buildTextButton(
      title: 'Show All',
      colorText: AppColors.backGroundColorButtonDefault,
      isUnderLineText: true,
    ),
  );
}
