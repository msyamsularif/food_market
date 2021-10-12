import 'package:flutter/material.dart';
import 'package:food_market/models/models.dart';
import 'package:get/get.dart';

import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentPage(
        transaction: Transaction(
          id: 1,
          food: mockFoods[1],
          quantity: 10,
          total: (mockFoods[1].price * 10 * 1.1).toInt() + 50000,
          dateTime: DateTime.now(),
          status: TransactionStatus.on_delivery,
          user: mockUser,
        ),
      ),
    );
  }
}
