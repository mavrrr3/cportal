class FormatterUtil {
  static int pfoneWithoutMask({required String phone}) => int.parse(phone.replaceAll(
        RegExp('[^0-9]'),
        '',
      ));
}
