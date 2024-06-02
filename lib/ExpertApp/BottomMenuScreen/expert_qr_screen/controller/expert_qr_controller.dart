import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:senorita/ScreenRoutes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertQRScannerController extends GetxController {
  ReceivePort port = ReceivePort();
  final downloadStatus =''.obs;
  final downloadProgress = 0.obs;
  final currentDownloadIndex = 0.obs;
  final pdfUrl = ''.obs;
  String? taskId;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final scannedData = ''.obs;
 final expertQrCode =''.obs;

  @override
  Future<void> onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expertQrCode.value= prefs.getString('expert_qr_code')??"";
    super.onInit();
  }
  @override
  void dispose() {
    controller?.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  callDownloaderFunction() {
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      int progress = data[2];
      print("progress...$progress");
      if (progress < 99 && progress > 1) {
        downloadStatus.value = 'running';
      } else if (progress > 99) {
        downloadStatus.value = 'completed';
        // Platform.isAndroid?
        FlutterDownloader.open(taskId: taskId!);
        // launchURL(pdfUrl.value);
      } else {
        downloadStatus.value = '';
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  downloadFile(String url)async{
    String dir = (await getApplicationDocumentsDirectory()).path;
    print("dir...$dir");
    // currentDownloadIndex.value = index;
    pdfUrl.value = url;
    taskId = await FlutterDownloader.enqueue(
    url: url,
    headers: {}, // optional: header send with url (auth token etc)
    savedDir:  Platform.isAndroid?
    '/storage/emulated/0/Download/':
    "$dir/",
    showNotification: true,
    openFileFromNotification: true,
    saveInPublicStorage: true,
    );

  }

  launchURL(final url) async {
    print('url....$url');
    final Uri url1 = Uri.parse(url.toString());
    if (!await launchUrl(url1,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }



// void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //
  //     // Update the scannedData observable with the scanned QR code data
  //     scannedData.value = scanData.code!;
  //     Get.toNamed(AppRoutes.paymentScreen);
  //   });
  // }

}
