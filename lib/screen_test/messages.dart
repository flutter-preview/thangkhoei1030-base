part of 'test_screen.dart';

Widget _buildMessagesPage(TestController controller) {
  return PageUtils.buildPageScaffold(
    appBar: PageUtils.buildAppBar(
      'Message',
      textStyle: Get.textTheme.titleLarge!
          .copyWith(shadows: BoxShadowsConst.shadowText),
      isLeading: false,
    ),
    body: _buildBody(controller),
  );
}

Widget _buildBody(TestController controller) {
  return Column(
    children: [
      CardUtils.buildCardCustomRadiusBorder(
        boxShadows: BoxShadowsConst.shadowCard,
        radiusAll: AppDimens.radius25,
        child: UtilWidget.buildInput(
          controller.searchCtr,
          iconLeading: Icons.search,
        ),
      ),
      Expanded(
        child: UtilWidget.buildScrollList(
          itemsCount: 10,
          itemWidget: (index) => _buildItemMessage(),
        ),
      )
    ],
  );
}

Widget _buildItemMessage() {
  return UtilWidget.itemLine(
    urlImages:
        'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
    heightLeading: 50,
    widthImageLeading: 50,
    radiusImageLeading: 50,
    title: AutoSizeText(
      'Sel de Mer Hotel & Suites',
      style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
    ),
    subtitle: RichText(
        text: TextSpan(
      children: [
        TextSpan(
          text: 'Xin chào, tôi có thể giúp gì cho bạn?',
          style: Get.textTheme.bodyText2!.copyWith(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        TextSpan(
          text: '\t1m',
          style: Get.textTheme.bodyText1!
        ),
      ],
    )),
  );
}
