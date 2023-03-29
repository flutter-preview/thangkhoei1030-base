part of 'test_screen.dart';

Widget _buildPageCategory(TestController controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar('AppBar',
        isLeading: false,
        textStyle: Get.textTheme.bodyText1!.copyWith(fontSize: 20),
        actions: [
          UtilButton.buildButtonWithIcon(
              icon: Icons.search, iconColor: Colors.black)
        ]),
    body: SingleChildScrollView(
      child: Column(children: [
        UtilWidget.buildScrollList(
          height: 100,
          itemsCount: controller.categoryListString.length,
          itemWidget: (index) {
            return _buildChipScroll(controller, index);
          },
          scrollDirection: Axis.horizontal,
        ),
        _buildSlideScroll(controller),
        buildCategoryHorizontal(),
      ]).paddingSymmetric(horizontal: AppDimens.paddingSmall),
    ),
  );
}

Widget _buildChipScroll(TestController controller, int index) {
  return Obx(
    () => ChoiceChip(
      onSelected: (value) {
        controller.indexSelect.value = index;
      },
      disabledColor: Colors.white,
      selected: index == controller.indexSelect.value,
      labelStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
      selectedColor: AppColors.backGroundColorButtonDefault,
      shape: controller.indexSelect.value == index
          ? null
          : StadiumBorder(
              side: BorderSide(
                  color: Color.fromARGB(
                      Color.getAlphaFromOpacity(0.14), 0, 0, 0))),
      label: Text(
        controller.categoryListString[index],
      ).paddingSymmetric(
        horizontal: AppDimens.paddingSmall,
      ),
    ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
  );
}

Widget _buildCardDetail(TestController controller) {
  return CardUtils.buildCardCustomRadiusBorder(
      boxShadows: BoxShadowsConst.shadowCard,
      radiusBottomLeft: 30,
      radiusTopRight: 30,
      child: SizedBox(
        height: 100,
        child: CardUtils.buildContentInCard(
          heightImage: 150,
          url:
              'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
          cardInfo: _buildDetailInfo(),
        ),
      ));
}

Widget _buildDetailInfo() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "title1",
                ),
                Text("title 2"),
              ],
            ),
          ),
          UtilWidget.buildAction(text: 4.7.toString(), iconData: Icons.star),
        ],
      ),
      const Divider(),
      Align(
        alignment: Alignment.bottomRight,
        child: UtilButton.buildTextButton(title: "View Detail"),
      )
    ],
  );
}

Widget _buildSlideScroll(TestController controller) {
  return UtilWidget.buildSlideTransition<TestController>(
    child: (index, controller) => _buildCardDetail(controller)
        .marginSymmetric(vertical: AppDimens.paddingVerySmall),
    currentIndexPosition: controller.currentPageScroll,
    itemsCount: 5,
    onPageChanged: (index, reason) =>
        controller.currentPageScroll.value = index,
  );
  // return Obx(
  //   () => Column(
  //     children: [
  //       CarouselSlider.builder(
  //         carouselController: controller.carouselController,
  //         disableGesture: true,
  //         itemsCount: 5,
  //         itemBuilder: (context, index, realIndex) {
  //           return _buildCardDetail(controller)
  //               .marginSymmetric(vertical: AppDimens.paddingVerySmall);
  //         },
  //         options: CarouselOptions(
  //           enableInfiniteScroll: true,
  //           enlargeCenterPage: true,
  //           disableCenter: true,
  //           enlargeFactor: 0.5,
  //           autoPlay: true,
  //           scrollPhysics: const BouncingScrollPhysics(),
  //           viewportFraction: 1,
  //           aspectRatio: 4 / 3,
  //           onPageChanged: (index, reason) =>
  //               controller.currentPageScroll.value = index,
  //         ),
  //       ),
  //       DotsIndicator(
  //         onTap: (position) {
  //           controller.currentPageScroll.value = position.toInt();
  //           controller.carouselController
  //               .jumpToPage(controller.currentPageScroll.value);
  //         },
  //         dotsCount: 5,
  //         position: controller.currentPageScroll.value.toDouble(),
  //         decorator: DotsDecorator(
  //           activeColor: AppColors.backGroundColorButtonDefault,
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}

Widget buildCategoryHorizontal() {
  return UtilWidget.buildLiStScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Title'),
    itemsCount: 10,
    itemsWidget: (index) => CardUtils.buildCardCustomRadiusBorder(
        blurRadius: 20,
        spreadRadius: 0.1,
        radiusAll: 10,
        boxShadows: BoxShadowsConst.shadowCard,
        child: UtilWidget.buildItemLine(
          trailing: UtilWidget.buildAction(
            text: 4.8.toString(),
            iconData: Icons.star,
          ),
          spacing: 10,
          heightImage: 60,
          widthImage: 60,
          borderRadiusImage: 12,
          child: const Text('ai do da dua em di roi bo lai'),
          urlLeading:
              'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
        ).paddingSymmetric(
          vertical: AppDimens.paddingVerySmall,
          horizontal: AppDimens.paddingSmall,
        )),
    separatorWidget: WidgetConst.sizedBoxPadding,
    scrollDirection: Axis.vertical,
  );
}
