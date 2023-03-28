part of 'test_screen.dart';

Widget _buildLogin(TestController controller) {
  return PageUtils.buildPageStackAppBar(
    
    appBar: PageUtils.buildAppBar('AppBar'),
    body: SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Heading",
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UtilWidget.buildInput(
                  controller.textEditingController,
                ),
                UtilWidget.buildInput(
                  controller.textEditingController2,
                ),
                WidgetConst.sizedBoxPadding,
                UtilButton.buildButton(ButtonModel(
                  btnTitle: 'btnTitle',
                  borderRadius: BorderRadius.circular(20),
                )),
                WidgetConst.sizedBoxPadding,
                UtilButton.buildButton(
                  ButtonModel(
                    btnTitle: 'btnTitle',
                    borderRadius: BorderRadius.circular(20),
                    textColor: Colors.black,
                    colors: [Colors.white],
                  ),
                ),
              ],
            )),
            WidgetConst.sizedBoxPadding,
            UtilButton.buildTextButton(
                title: 'underline', isUnderLineText: true),
          ],
        ),
      ),
    ),
  );
}


// CardUtils.buildCardDecriptionsDetail(
//           url:
//               ,
//           title: 'TITLE',
//           cardInfo: Container(),
//         ),