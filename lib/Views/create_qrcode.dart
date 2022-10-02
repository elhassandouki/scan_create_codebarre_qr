import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:scan_create_codebarre_qr/ads/Ads.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _screenshotController = ScreenshotController();
  final controller = TextEditingController();
  final globalKey = GlobalKey();
  File? file;
  Uint8List? _imageFile;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFFF835F),
              Color(0xFFFC663C),
              Color(0xFFFF3F1A),
            ]),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Screenshot(
                    controller: _screenshotController,
                    child: buildQrCode(),
                  ),
                  SizedBox(height: 40),
                  buildTextField(context),

                  /* ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        child: Text(
                          'partage ...',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFF3F1A), // background
                          onPrimary: Colors.white // foreground
                          ),
                      onPressed: () async {
                        final img = await _screenshotController
                            .captureFromWidget(buildQrCode());
                        _saveImgShared(img);
                      }),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      child: Text(
                        'save image  ...',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF3F1A), // background
                        onPrimary: Colors.white // foreground
                        ),
                    onPressed: () async {
                      final img = await _screenshotController.capture();
                      if (img == null) return;
                      await _saveImg(img);
                    },
                  )*/
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFFF835F),
          focusColor: Colors.white,
          onPressed: () async {
            final img =
                await _screenshotController.captureFromWidget(buildQrCode());
            _saveImgShared(img);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.share),
        ),
      );

  Widget buildQrCode() => QrImage(
        data: controller.text,
        version: QrVersions.auto,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        gapless: false,
        size: 200,
      );
  Future _saveImgShared(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final img = File('${directory.path}/Qrcode.png');
    img.writeAsBytesSync(bytes);
    await Share.shareFiles([img.path]);
  }

  Future<String> _saveImg(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final _name = 'screen_$time';
    final data = await ImageGallerySaver.saveImage(bytes, name: _name);
    return data['filePath'];
  }

  Future _takeScreenshot(Uint8List bytes) async {
    var imageuint = await _screenshotController.capture();
    var directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/sfs.png');
    imgFile.writeAsBytesSync(bytes);
    Share.shareFiles([imgFile.path]);
  }

  Widget buildTextField(BuildContext context) => TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: 'Enter the Data',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          suffixIcon: IconButton(
            color: Colors.white,
            icon: Icon(Icons.done_outline_sharp, size: 30),
            onPressed: () => setState(() {}),
          ),
        ),
      );
}
