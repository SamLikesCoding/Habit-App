import 'dart:math';

String randomKey(int length) {
  const charset =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => charset.codeUnitAt(
        random.nextInt(charset.length),
      ),
    ),
  );
}
