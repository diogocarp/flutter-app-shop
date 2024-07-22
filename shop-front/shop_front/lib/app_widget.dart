import 'package:flutter/material.dart';
import 'package:shop_front/config/app_controller.dart';
import 'package:shop_front/screens/conf_page.dart';
import 'package:shop_front/screens/cart_page.dart';
import 'package:shop_front/screens/login_page.dart';
import 'package:shop_front/screens/payment-pages/credit_payment.dart';
import 'package:shop_front/screens/payment-pages/debit_payment.dart';
import 'package:shop_front/screens/payment-pages/pix_payment.dart';
import 'package:shop_front/screens/payment_page.dart';
import 'package:shop_front/screens/start_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light),
          initialRoute: '/start',
          routes: {
            '/start': (context) => StartPage(),
            '/login': (context) => LoginPage(),
            '/cart': (context) => CartPage(),
            '/conf': (context) => ConfPage(),
            '/payment': (context) => PaymentPage(),
            '/confirm-cc': (context) => CreditPayment(),
            '/confirm-cd': (context) => DebitPayment(),
            '/confirm-pix': (context) => PixPayment()
          },
        );
      },
    );
  }
}
