import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class DownloadAPK extends StatefulWidget {
  const DownloadAPK({Key? key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<DownloadAPK> {
  var apkUrl =
      'http://47.97.159.103:3000/uploads/0616121b49dc04e99953507e61f375c13704e43b37962cfc0a528a48c8d2abcb.apk';
  late http.Client _client;
  late String _filePath;
  double _progress = 0;
  late String _destPath;

  _downloadAPK() async {
    // try {
    //   final Directory? externalDir = await getExternalStorageDirectory();
    //   _filePath = '${externalDir?.path}/miyoushe.apk';

    //   final http.Response response = await _client.get(
    //     Uri.parse(apkUrl),
    //     headers: {'Content-Type': 'application/octet-stream'},
    //   ).send();

    //   final int contentLength = response.contentLength!;
    //   final File file = File(_filePath);
    //   final IOSink sink = file.openWrite();

    //   final Completer<void> completer = Completer<void>();
    //   int received = 0;

    //   response.stream.listen(
    //     (List<int> chunk) {
    //       sink.add(chunk);
    //       received += chunk.length;

    //       if (contentLength > 0) {
    //         final double progress = received / contentLength;
    //         setState(() {
    //           _progress = progress;
    //         });
    //       }
    //     },
    //     onDone: () {
    //       sink.close();
    //       completer.complete();
    //       print('APK downloaded to: $_filePath');
    //     },
    //     onError: (dynamic error) {
    //       sink.close();
    //       completer.completeError(error);
    //       print('Error downloading APK: $error');
    //     },
    //     cancelOnError: true,
    //   );

    //   await completer.future;
    // } catch (e) {
    //   print('Error downloading APK: $e');
    // }
  }

  @override
  void initState() {
    super.initState();
    _downloadAPK();
    getApplicationDocumentsDirectory()
        .then((tempDir) => {_destPath = tempDir.path + '/zakiFlutter.docx'});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _downloadAPK();
      },
      child: Row(children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            value: _progress,
            strokeWidth: 2,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffffe14c)),
          ),
        )
      ]),
    );
  }
}
