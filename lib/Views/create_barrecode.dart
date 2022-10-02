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
import 'package:barcode_widget/barcode_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scan_create_codebarre_qr/ads/Ads.dart';

class CreateBarreCodePage extends StatefulWidget {
  @override
  _CreateBarreCodePageState createState() => _CreateBarreCodePageState();
}

class _CreateBarreCodePageState extends State<CreateBarreCodePage> {
  final screen_shotController = ScreenshotController();
  final controller = TextEditingController();
  final globalKey = GlobalKey();
  File? file;
  Uint8List? _imageFile;
  BannerAd? bannerAd;
  bool isloaded = false;
  final AdSize _adSize = AdSize.banner;

  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
      adUnitId: Ads.bannerAdUnitId,
      request: AdRequest(),
      size: _adSize,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isloaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    bannerAd!.load();
  }

  /* void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isloaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    bannerAd!.load();
  }*/

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (isloaded == true) {
      return Container(
        height: _adSize.height.toDouble(),
        width: _adSize.width.toDouble(),
        child: AdWidget(
          ad: bannerAd!,
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

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
                    controller: screen_shotController,
                    child: buildBarCode(),
                  ),
                  SizedBox(height: 40),
                  buildTextField(context),
                  Spacer(),
                  checkForAd(),
                  /*ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        child: Text(
                          'partage image ...',
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
                      }),*/
                  // This trailing comma makes auto-formatting nicer for build methods.
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
                await screen_shotController.captureFromWidget(buildQrCode());
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
  Widget buildBarCode() => BarcodeWidget(
        barcode: Barcode.code128(),
        data: controller.text,
        backgroundColor: Colors.white,
        color: Colors.black,
        width: 200,
        height: 200,
        //padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
      );

  Future _saveImgShared(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final img = File('${directory.path}/Barcode.png');
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
    var imageuint = await screen_shotController.capture();
    var directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/barcode_test.png');
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
