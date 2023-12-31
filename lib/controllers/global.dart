import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imitate_miyoushe/utils/game_category_data.dart';
import 'package:imitate_miyoushe/common/game_category_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:imitate_miyoushe/utils/compare_versions.dart';

class GlobalController extends GetxController {
  RxMap currentGameCategory = {}.obs;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  RxString packageVersion = ''.obs;
  // 获取当前app版本信息
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    packageVersion.value = info.version;
  }

  // 获取app最新版本信息
  var latestPackageInfo = {}.obs;
  Future getLatestVersion() async {
    const String apiUrl = 'http://47.97.159.103:3000/api/latestVersion';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      latestPackageInfo.value =
          List.from(data['data']).isNotEmpty ? data['data'][0] : {};
      int result = compareVersions(
          _packageInfo.version, latestPackageInfo['version_number']);
      if (result < 0) {
        showUpdateDialog();
      }
      return result;
    } else {
      return Get.snackbar('提示', '获取最新版本信息失败');
    }
  }

  // 获取文件保存路径
  Future<String> _apkLocalPath() async {
    final directory = await getExternalStorageDirectory();
    var localPath = directory!.path.toString();
    return localPath;
  }

  // 获取权限
  Future<bool> getPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      var requestStatuse = await Permission.storage.request();
      if (requestStatuse.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  final RxBool _isDownloadSuccess = false.obs;
  RxString savePath = ''.obs;
  // 下载apk
  Future<void> downloadFile() async {
    try {
      bool permission = await getPermission();
      if (!permission) {
        Get.back();
        return;
      }
      final String documentsPath = await _apkLocalPath();
      savePath.value = '$documentsPath/miyoushe.apk';
      await dio.download(
        latestPackageInfo['download_link'],
        savePath.value,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            progress.value = received / total;
          }
        },
      );
      _isDownloadSuccess.value = true;
      installAPK();
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  // 安装apk
  installAPK() async {
    final res = await InstallPlugin.install(savePath.value);
    if (res['isSuccess']) {
      Get.back();
    }
  }

  final RxBool isDownloading = false.obs;
  late Dio dio;
  RxDouble progress = 0.0.obs;
  // 显示更新对话框
  showUpdateDialog() {
    Get.defaultDialog(
      // barrierDismissible: false,
      radius: 10,
      title: '发现新版本',
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      content: Column(
        children: [
          Text(
            '当前版本${packageVersion.value}',
            style: const TextStyle(
              color: Color.fromARGB(255, 173, 174, 175),
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            latestPackageInfo['release_notes'],
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
      actions: [
        Obx(
          () => Column(
            children: [
              !_isDownloadSuccess.value && !isDownloading.value
                  ? ElevatedButton(
                      onPressed: () {
                        isDownloading.value = true;
                        downloadFile();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff1f2233),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(30, 1, 30, 1),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: const Text(
                        '马上更新',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : Container(),
              !_isDownloadSuccess.value && isDownloading.value
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: LinearProgressIndicator(
                        value: progress.value,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xff70e2ff),
                        ),
                      ),
                    )
                  : Container(),
              _isDownloadSuccess.value
                  ? ElevatedButton(
                      onPressed: () {
                        installAPK();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff1f2233),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(30, 1, 30, 1),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: const Text(
                        '立即安装',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : Container(),
              Text(
                '新版本${latestPackageInfo['version_number']}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 173, 174, 175),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // 检查更新对话框
  checkForUpdates() async {
    var result = await getLatestVersion();
    if (result is int) {
      if (result < 0) {
        showUpdateDialog();
      } else {
        Get.defaultDialog(
          radius: 10,
          title: '提示',
          titleStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          titlePadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
          content: Column(
            children: [
              Text(
                '当前版本${packageVersion.value}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 173, 174, 175),
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '您当前使用的是最新版本',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff1f2233),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.fromLTRB(30, 1, 30, 1),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              child: const Text(
                '确定',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            )
          ],
        );
      }
    }
  }

  showGameCategoryDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return GameCategoryDialog();
      },
    );
  }

  selectGameCategory(data) {
    currentGameCategory["name"] = data["name"];
    currentGameCategory["id"] = data["id"];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    dio = Dio();
    var data = {
      "name": gameCategoryData[0]["name"],
      "id": gameCategoryData[0]["id"],
    };
    selectGameCategory(data);
    _initPackageInfo();
    getLatestVersion();
  }
}
