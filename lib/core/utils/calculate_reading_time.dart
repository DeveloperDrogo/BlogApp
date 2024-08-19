int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingtime = wordCount / 225;
  return readingtime.ceil();
}
