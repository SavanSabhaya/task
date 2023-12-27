import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/common/widgets/common_button.dart';
import 'package:task/pages/scan_qr_code/bloc/scan_qr_code_bloc.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';

import '../../utils/CustomSnackBar.dart';

class ScanQRCodeScreen extends StatefulWidget {
  const ScanQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<ScanQRCodeScreen> createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ScanQRCodeBloc, ScanQRCodeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return AppBackgroundContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  labelPairController,
                  style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_32),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Lorem Ipsum, Or Lipsum As It Is Sometimes Know.",
                  style: AppThemeState().textStyleMedium(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Center(
                    child: _buildQrView(context),
                  ),
                ),
                CommonButton(
                  buttonText: labelFetchingData,
                  onTap: () {
                    Navigator.popAndPushNamed(context, routeDashboard);
                  },
                ),
                SizedBox(
                  height: 18.h,
                ),
              ],
            ),
          ); //_buildQrView(context);
        },
        // child: CommonShimmer(childWidget: childShimmer(context)),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      formatsAllowed: const [BarcodeFormat.qrcode],
      onQRViewCreated: _onQRViewCreated,
      cameraFacing: CameraFacing.back,
      overlay: QrScannerOverlayShape(
        cutOutHeight: 265.h,
        cutOutWidth: 265.w,
        overlayColor: Colors.white,
        borderColor: ColorConstants.primaryColor,
        borderRadius: 10.r,
        borderLength: 40.h,
        borderWidth: 5.w,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Widget childShimmer(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showSuccessSnackBar(context, "Pratik");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 13,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: ColorConstants.colorShimmerColor,
                      borderRadius: BorderRadius.all(Radius.circular(17)),
                    )),
                ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, indexx) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 10,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: ColorConstants.colorShimmerColor,
                                borderRadius: BorderRadius.all(Radius.circular(17)),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorConstants.colorShimmerColor),
                                    color: ColorConstants.colorShimmerColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  height: 50,
                                  width: 40,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                      height: 55,
                                      decoration: const BoxDecoration(
                                        color: ColorConstants.colorShimmerColor,
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      )),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          );
        });
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        this.controller!.pauseCamera();
        Navigator.pushNamed(context, routeConnectDevice, arguments: {"macAddress": scanData.code});
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
