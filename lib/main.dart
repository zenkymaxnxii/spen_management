import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:spen_management/data/data_local.dart';
import 'package:spen_management/models/spend_type.dart';
import 'package:spen_management/presentation/home/home_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'spend.db'),
    version: 1,
  );
  if (await SQLManagement(db: database).createTable()) {
    if (kDebugMode) {
      print("Created table success");
      List<SpendType> listSpen = [
        SpendType(spendName: "Ăn uống", icon: "meal.png", type: 0, id: 1),
        SpendType(spendName: "Quần áo", icon: "laundry.png", type: 0, id: 2),
        SpendType(spendName: "Mỹ phẩm", icon: "cosmetics.png", type: 0, id: 3),
        SpendType(spendName: "Phí giao lưu", icon: "beer.png", type: 0, id: 4),
        SpendType(
            spendName: "Tiền điện", icon: "electric_bill.png", type: 0, id: 5),
        SpendType(
            spendName: "Tiền nước", icon: "water_bill.png", type: 0, id: 6),
        SpendType(spendName: "Tiền nhà", icon: "home_bill.png", type: 0, id: 7),
        SpendType(spendName: "Đi lại", icon: "petrol.png", type: 0, id: 8),
        SpendType(spendName: "Y tế", icon: "healthcare.png", type: 0, id: 9),
        SpendType(
            spendName: "Giáo dục", icon: "education.png", type: 0, id: 10),
        SpendType(
            spendName: "Liên lạc", icon: "communicate.png", type: 0, id: 11),
        SpendType(spendName: "Tiền lương", icon: "wallet.png", type: 1, id: 12),
        SpendType(spendName: "Phụ cấp", icon: "pig.png", type: 1, id: 13),
        SpendType(spendName: "Tiền thưởng", icon: "gift.png", type: 1, id: 14),
        SpendType(
            spendName: "Thu nhập phụ", icon: "money_bag.png", id: 15, type: 1)
      ];
      for (var spen in listSpen) {
        if (await SQLManagement(db: database).insert(spen) != -1) {
          print("insert success");
        }
      }
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.black,
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              statusBarColor: Colors.black),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
