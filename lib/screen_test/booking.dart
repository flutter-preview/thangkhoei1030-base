part of 'test_screen.dart';

Widget _buildBooking(TestController controller) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
    ),
    body: GetBuilder<TestController>(
      builder: (controller) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: PageUtils.buildAppBarTitle(
              'Booking',
              style: Get.textTheme.titleMedium!.copyWith(
                shadows: BoxShadowsConst.shadowText,
                fontSize: AppDimens.sizeTextLarge,
              ),
            ),
          ),
          WidgetConst.sizedBox18,
          controller.isRangeDateSelect
              ? _buildInfoTime(controller)
              : Align(
                  alignment: Alignment.center,
                  child: _buildTimeDetail(controller.selectedDay, 'In')),
          WidgetConst.sizedBox18,
          Align(
            alignment: Alignment.centerLeft,
            child: UtilWidget.buildTitle(
              text: DateFormat(DateFormat.YEAR_MONTH).format(
                controller.focusedDay ?? DateTime.now(),
              ),
              colorText: AppColors.backGroundColorButtonDefault,
            ),
          ),
          WidgetConst.sizedBoxPadding,
          _buildRangeTime(controller),
          WidgetConst.sizedBox40,
          _buildNumberOfNight(controller),
          WidgetConst.sizedBox18,
          _buildInfoOrder(controller),
          WidgetConst.sizedBoxPadding,
          _buildButton()
        ],
      ).paddingSymmetric(
        horizontal: AppDimens.paddingLarge,
      ),
    ),
  );
}

Widget _buildRangeTime(TestController controller) {
  return TableCalendar(
    headerVisible: false,
    calendarStyle: CalendarStyle(
      todayDecoration: BoxDecoration(
          color: AppColors.backGroundColorButtonDefault,
          shape: BoxShape.circle),
      selectedDecoration: BoxDecoration(
        color: AppColors.backGroundColorButtonDefault,
        shape: BoxShape.circle,
      ),
      rangeHighlightColor: AppColors.rangeTimeSelect,
      rangeEndDecoration: BoxDecoration(
        color: AppColors.backGroundColorButtonDefault,
        shape: BoxShape.circle,
      ),
      rangeStartDecoration: BoxDecoration(
        color: AppColors.backGroundColorButtonDefault,
        shape: BoxShape.circle,
      ),
    ),
    calendarFormat: CalendarFormat.month,
    rangeEndDay: controller.endDay,
    rangeStartDay: controller.startDay,
    rangeSelectionMode: controller.isRangeDateSelect
        ? RangeSelectionMode.toggledOn
        : RangeSelectionMode.toggledOff,
    onRangeSelected: controller.onRangeDaySelect,
    firstDay: DateTime.utc(2010, 10, 16),
    lastDay: DateTime.utc(2099, 3, 14),
    // onDayLongPressed: (selectedDay, focusedDay) => ,
    currentDay: controller.selectedDay,
    onDaySelected: controller.onDaySelected,
    onPageChanged: (focusedDay) {
      controller.focusedDay = focusedDay;
      controller.update();
    },

    // currentDay: controller.isRangeDateSelect ? null : controller.selectedDay,
    calendarBuilders: CalendarBuilders(
      selectedBuilder: (context, day, focusedDay) => Text(
        day.day.toString(),
      ),
    ),

    focusedDay: controller.focusedDay ?? DateTime.now(),
  );
}

Widget _buildTimeDetail(
  DateTime? dateTime,
  String title,
) {
  TextStyle textStyle = Get.textTheme.bodyText2!
      .copyWith(color: AppColors.backGroundColorButtonDefault);
  return Column(
    children: [
      Opacity(
        opacity: dateTime != null ? 1 : 0,
        child: AutoSizeText(
          title,
          style: textStyle,
        ),
      ),
      WidgetConst.sizedBoxPaddingSmall,
      dateTime != null
          ? AutoSizeText(
              DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(dateTime),
              style: Get.textTheme.titleMedium!
                  .copyWith(color: AppColors.backGroundColorButtonDefault),
            )
          : AutoSizeText(
              'Please select a day',
              style: Get.textTheme.bodyText2,
            ),
      WidgetConst.sizedBoxPaddingSmall,
      Opacity(
        opacity: dateTime != null ? 1 : 0,
        child: AutoSizeText(
          DateFormat(DateFormat.WEEKDAY).format(dateTime ?? DateTime.now()),
          style: textStyle,
        ),
      ),
    ],
  ).paddingSymmetric(
    // horizontal: AppDimens.padding35,
    vertical: AppDimens.paddingSmall,
  );
}

Widget _buildInfoTime(TestController controller) {
  Rx<DateTime?> dateTime = controller.startDay.obs;
  return Obx(
    () => Row(
      children: [
        Expanded(
            child: InkWell(
          onTap: () => dateTime.value = controller.startDay,
          child: CardUtils.buildCardCustomRadiusBorder(
            radiusAll: 20,
            boxShadows: dateTime.value == controller.startDay
                ? BoxShadowsConst.shadowCard
                : null,
            child: _buildTimeDetail(controller.startDay, 'From'),
          ),
        )),
        WidgetConst.sizedBoxWidth10,
        Expanded(
          child: InkWell(
            onTap: () => dateTime.value = controller.endDay,
            child: CardUtils.buildCardCustomRadiusBorder(
              radiusAll: 20,
              boxShadows: dateTime.value == controller.endDay
                  ? BoxShadowsConst.shadowCard
                  : null,
              child: _buildTimeDetail(controller.endDay, 'To'),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoOrder(TestController controller) {
  return Row(
    children: [
      Expanded(
        child: _buildInputPeople(
          controller,
          title: 'Adult',
          textEditingController: controller.adult,
        ),
      ),
      WidgetConst.sizedBoxWidth10,
      Expanded(
          child: _buildInputPeople(
        controller,
        title: 'Kids',
        textEditingController: controller.kids,
      )),
    ],
  );
}

Widget _buildNumberOfNight(TestController controller) {
  return CardUtils.buildCardCustomRadiusBorder(
    backgroundColor: AppColors.backgroundColorInput,
    radiusAll: AppDimens.radius32,
    child: Row(
      children: [
        const AutoSizeText('Number of nights:')
            .paddingOnly(left: AppDimens.paddingLarge),
        const Spacer(),
        AutoSizeText(controller.numberOfNight.toString())
      ],
    ).paddingAll(AppDimens.padding22),
  );
}

Widget _buildInputPeople(
  TestController controller, {
  required String title,
  required TextEditingController textEditingController,
  bool isReadOnly = false,
}) {
  return CardUtils.buildCardCustomRadiusBorder(
    backgroundColor: AppColors.backgroundColorInput,
    radiusAll: AppDimens.radius32,
    child: Row(
      children: [
        AutoSizeText(title).paddingOnly(left: AppDimens.paddingLarge),
        Expanded(
          child: UtilWidget.buildInput(
            textEditingController,
            borderRadius: 0,
            fillColor: AppColors.backgroundColorInput.withOpacity(0.1),
            alignText: TextAlign.end,
            inputFormatters: InputFormatter.digitsOnly,
            isUseSuffixIcon: false,
            textInputType: TextInputType.number,
            isReadOnly: isReadOnly,
          ),
        ),
      ],
    ),
  );
}

Widget _buildButton() {
  return SizedBox(
    width: Get.width - Get.width * (1 - AppDimens.resolutionWidgetButton) * 2,
    child: CardUtils.buildCardCustomRadiusBorder(
      radiusAll: AppDimens.radius20,
      boxShadows: BoxShadowsConst.shadowCard,
      child: UtilButton.buildButton(
        ButtonModel(btnTitle: 'btnTitle'),
      ),
    ),
  );
}
