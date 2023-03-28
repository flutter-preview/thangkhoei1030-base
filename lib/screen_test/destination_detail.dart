part of 'test_screen.dart';

Widget _buildPageDestinationDetail(TestController controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar('Destination Detail',
        textStyle: Get.textTheme.titleMedium,
        actions: [
          UtilButton.buildButtonWithIcon(
              visibilityBorder: true,
              icon: Icons.search,
              iconColor: Colors.black),
        ]),
    body: SingleChildScrollView(
      child: Column(
        children: [
          UtilWidget.buildSlideTransition<TestController>(
            heightScroll: 300,
            viewportFraction: 0.55,
            child: (index, controller) => _buildDetail(index, controller),
            itemCount: 5,
            currentIndexPosition: controller.currentPageScroll,
            isUsingDotIndicator: false,
            onPageChanged: (index, reason) =>
                controller.currentPageScroll.value = index,
          ),
          WidgetConst.sizedBoxPadding,
          _buildPicture(),
          WidgetConst.sizedBoxPadding,
          buildOtherPlace(),
        ],
      ),
    ),
  );
}

Widget _buildDetail(int index, TestController controller) {
  return Obx(
    () => CardUtils.buildCardCustomRadiusBorder(
      isBorderAll: true,
      radiusAll: 20,
      child: CardUtils.buildContentInCard(
          url:
              'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
          cardInfo: controller.currentPageScroll.value == index
              ? Column(
                  children: [
                    const Text('data'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) => Icon(Icons.star)),
                    ),
                  ],
                )
              : SizedBox()),
    ),
  );
}

Widget buildOtherPlace() {
  return UtilWidget.buildLiStScrollWithTitle(
    leading:
        Text("title,").paddingSymmetric(horizontal: AppDimens.paddingSmall),
    actionWidget: Text("View detail,"),
    items: [1, 2, 3, 4, 5, 6],
    itemsWidget: (index) => _buildItemInOtherPlace(),
    scrollDirection: Axis.horizontal,
    height: 75,
    isScroll: true,
    separatorWidget: WidgetConst.sizedBoxWidth10,
  ).paddingSymmetric(
    horizontal: AppDimens.paddingVerySmall,
  );
}

Widget _buildItemInOtherPlace() {
  return Stack(
    children: [
      UtilWidget.buildImageWidget(
        'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
        heightImage: 75,
        widthImage: 95,
        raidus: 10,
      ),
      Positioned(
          top: double.infinity / 2,
          left: 10,
          child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Text(
                'data',
                style: Get.textTheme.bodyText1!
                    .copyWith(color: AppColors.textColorWhite),
              )))
    ],
  );
}

Widget _buildPicture() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("data"),
      WidgetConst.sizedBoxPadding,
      SizedBox(
        width: Get.width,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: UtilWidget.buildImageWidget(
                  widthImage: double.infinity,
                  'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
                ),
              ),
              WidgetConst.sizedBoxWidth10,
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: UtilWidget.buildImageWidget(
                        'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
                        widthImage: double.infinity,
                        heightImage: 100,
                      ),
                    ),
                    WidgetConst.sizedBoxPadding,
                    Expanded(
                      child: UtilWidget.buildImageWidget(
                        'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
                        widthImage: double.infinity,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ],
  ).paddingSymmetric(horizontal: AppDimens.paddingSmall);
}
