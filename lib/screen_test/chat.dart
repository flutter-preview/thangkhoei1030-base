part of 'test_screen.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

Widget _buildChatMessage(TestController controller) {
  return PageUtils.buildPageScaffold(
    appBar: PageUtils.buildAppBar('Sel de Mer Hotel & Suites',
        textStyle: Get.textTheme.titleMedium),
    body: GetBuilder<TestController>(
      builder: (controller) => Chat(
        messages: controller.messages,
        customMessageBuilder: (p0, {required messageWidth}) => const SizedBox(),
        bubbleBuilder: (child,
                {required message, required nextMessageInGroup}) =>
            const SizedBox(),
        // bubbleBuilder: (child,
        //         {required types.Message message,
        //         required bool nextMessageInGroup}) =>
        //     Message(
        //       customMessageBuilder: (p0, {required messageWidth}) => ,
        //   message: message,
        //   emojiEnlargementBehavior: EmojiEnlargementBehavior.multi,
        //   hideBackgroundOnEmojiMessages: false,
        //   messageWidth: (Get.width / 3).toInt(),
        //   roundBorder: true,
        //   showAvatar: true,
        //   showName: true,
        //   showStatus: true,
        //   showUserAvatars: true,
        //   textMessageOptions: const TextMessageOptions(),
        //   usePreviewData: false,
        // ),

        onSendPressed: (partialText) =>
            controller.handleSendPressed(partialText.text),
        //currrent_user
        user: controller.user2,
        avatarBuilder: (userId) {
          return const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
            ),
          );
        },
        // nameBuilder: (userId) => Text(
        //   userId,
        //   style: Get.textTheme.bodyText1,
        // ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        onPreviewDataFetched: controller.handlePreviewDataFetched,
        showUserAvatars: true,
        showUserNames: true,
        onAttachmentPressed: controller.sendImage,
        customBottomWidget: _buildBottomChat(controller),
      ),
    ),
  );
}

Widget _buildBottomChat(TestController controller) {
  return Row(
    children: [
      IconButton(
          onPressed: controller.sendImage,
          icon: const Icon(Icons.image, size: AppDimens.sizeIconLarge)),
      Expanded(
        child: UtilWidget.buildInput(
          controller.searchCtr,
          fillColor: AppColors.inputText(),
          hintText: "Send message",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
        ).paddingSymmetric(horizontal: AppDimens.paddingMedium),
      ),
      IconButton(
          onPressed: () =>
              controller.handleSendPressed(controller.searchCtr.text),
          icon: const Icon(
            Icons.send,
            size: AppDimens.sizeIconLarge,
          ))
    ],
  ).paddingSymmetric(
    vertical: AppDimens.paddingSmall,
    horizontal: AppDimens.paddingSmall,
  );
}
