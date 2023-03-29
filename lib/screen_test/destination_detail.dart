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
            itemsCount: 5,
            currentIndexPosition: controller.currentPageScroll,
            isUsingDotIndicator: false,
            onPageChanged: (index, reason) =>
                controller.currentPageScroll.value = index,
          ),
          Column(
            children: [
              WidgetConst.sizedBoxPadding,
              _buildPicture(),
              WidgetConst.sizedBoxPadding,
              buildButton(),
              WidgetConst.sizedBoxPadding,
              buildOtherPlace(),
              WidgetConst.sizedBoxPadding,
              _buildComment(),
            ],
          ).paddingSymmetric(
            horizontal: AppDimens.paddingVerySmall,
          )
        ],
      ),
    ),
  );
}

Widget _buildDetail(int index, TestController controller) {
  return Obx(
    () => CardUtils.buildCardCustomRadiusBorder(
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
                      children:
                          List.generate(5, (index) => const Icon(Icons.star)),
                    ),
                  ],
                )
              : const SizedBox()),
    ),
  );
}

Widget buildOtherPlace() {
  return UtilWidget.buildLiStScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Other place'),
    actionWidget: UtilButton.buildTextButton(title: 'View Detail,'),
    itemsCount: 5,
    itemsWidget: (index) => _buildItemInOtherPlace(),
    scrollDirection: Axis.horizontal,
    height: 75,
    isScroll: true,
    separatorWidget: WidgetConst.sizedBoxWidth10,
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
      UtilWidget.buildTitle(text: "Pictures"),
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
  );
}

Widget _buildComment() {
  return UtilWidget.buildLiStScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Comment'),
    itemsCount: 2,
    isScroll: false,
    itemsWidget: (i) {
      return Column(
        children: [
          buildItemComment(),
          WidgetConst.sizedBox10,
          UtilWidget.buildScrollList(
              isScroll: false,
              itemsCount: 2,
              itemWidget: (index) {
                return buildItemComment(isReplyComment: true);
              },
              separatorWidget: WidgetConst.sizedBox10,
              scrollDirection: Axis.vertical),
          WidgetConst.sizedBoxPadding,
        ],
      ).paddingOnly(left: 25, right: AppDimens.padding15);
    },
    scrollDirection: Axis.vertical,
  );
}

Widget buildItemComment({
  bool isReplyComment = false,
}) {
  return Row(
    children: [
      const Icon(
        Icons.account_circle_outlined,
        size: AppDimens.sizeIcon40,
      ),
      Expanded(
        child: CardUtils.buildCardCustomRadiusBorder(
          child: Container(
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Ngo ngoc sang",
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    AutoSizeText(
                      "Ngo ngoc sang",
                      style: Get.textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
                const Divider(
                  color: Colors.white,
                  height: 10,
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UtilWidget.buildAction(
                        text: "like",
                        iconData: Icons.favorite_outline,
                        iconSize: AppDimens.sizeIconSmall),
                    UtilWidget.buildAction(
                        text: "comment",
                        iconData: Icons.favorite_outline,
                        iconSize: AppDimens.sizeIconSmall),
                    UtilWidget.buildAction(
                        text: "share",
                        iconData: Icons.favorite_outline,
                        iconSize: AppDimens.sizeIconSmall),
                  ],
                ).paddingSymmetric(horizontal: AppDimens.paddingMedium)
              ],
            ),
          ),
          radiusAll: 10,
        ).paddingOnly(
          left: AppDimens.defaultPadding,
          top: AppDimens.paddingLabel,
          bottom: AppDimens.paddingLabel,
        ),
      ),
    ],
  ).paddingOnly(left: isReplyComment ? AppDimens.padding25 : 0);
}

Widget buildButton() {
  return CardUtils.buildCardCustomRadiusBorder(
    radiusAll: AppDimens.radiusButtonDefault,
    boxShadows: BoxShadowsConst.shadowCard,
    child: UtilButton.buildButton(
        ButtonModel(btnTitle: 'Books', colors: [AppColors.backGroundColorButtonDefault])),
  );
}
