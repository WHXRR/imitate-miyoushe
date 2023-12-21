int compareVersions(String version1, String version2) {
  List<int> v1Parts = version1.split('.').map(int.parse).toList();
  List<int> v2Parts = version2.split('.').map(int.parse).toList();

  // 使两个版本号的部分长度相同
  while (v1Parts.length < v2Parts.length) {
    v1Parts.add(0);
  }

  while (v2Parts.length < v1Parts.length) {
    v2Parts.add(0);
  }

  // 逐位比较版本号的各个部分
  for (int i = 0; i < v1Parts.length; i++) {
    if (v1Parts[i] < v2Parts[i]) {
      return -1;
    } else if (v1Parts[i] > v2Parts[i]) {
      return 1;
    }
  }

  return 0;
}
