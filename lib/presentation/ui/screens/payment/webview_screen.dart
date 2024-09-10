import 'package:ecommerce_1/presentation/state_holders/cart_list_state_holders/cart_list_controller.dart';
import 'package:ecommerce_1/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.paymentUrl});

  final String paymentUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (url.endsWith("tran_type=success")) {
              navigateBack();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("tran_type=success")) {
              navigateBack();
            }
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        shadowColor: Colors.white54,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }

  void navigateBack() {
    Navigator.pop(context);
    Get.snackbar('Payment successful',
        'Your order has been confirmed',
        backgroundColor:ColorPalette.primaryColor,
        colorText: Colors.white,
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM);
    Get.find<CartListController>().getCartList();
  }
}