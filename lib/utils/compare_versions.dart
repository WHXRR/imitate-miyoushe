int compareVersions(String version1, String version2) {
  List v1Parts = version1.split('.');
  List v2Parts = version2.split('.');

  // 使两个版本号的部分长度相同
  while (v1Parts.length < v2Parts.length) {
    v1Parts.add(0);
  }
  while (v2Parts.length < v1Parts.length) {
    v2Parts.add(0);
  }
  // 逐位比较版本号的各个部分
  for (int i = 0; i < v1Parts.length; i++) {
    String str1 = v1Parts[i];
    String str2 = v2Parts[i];
    while (str1.length < str2.length) {
      str1 += '0';
    }
    while (str2.length < str1.length) {
      str2 += '0';
    }
    int num1 = int.parse(str1);
    int num2 = int.parse(str2);
    if (num1 > num2) {
      return 1;
    } else if (num1 < num2) {
      return -1;
    }
  }
  // 两个版本号相等
  return 0;
}
