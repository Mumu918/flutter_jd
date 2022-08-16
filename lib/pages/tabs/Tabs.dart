import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Cart.dart';
import 'package:flutter_jd/pages/Category.dart';
import 'package:flutter_jd/pages/Home.dart';
import 'package:flutter_jd/pages/Mine.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> _pageList = const [Home(), Category(), Cart(), Mine()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('京东'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: ((index) {
            setState(() {
              _currentIndex = index;
            });
          }),
          fixedColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: '购物车'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
          ]),
    );
  }
}
