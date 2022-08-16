import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/tabs/Tabs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334), // 配置设计稿宽高
      builder: ((context, child) => MaterialApp(home: child)),
      child: const Tabs(),
    );
  }
}
