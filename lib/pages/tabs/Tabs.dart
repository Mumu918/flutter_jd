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
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  final List<Widget> _pageList = const [Home(), Category(), Cart(), Mine()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('京东'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: ((value) {
          setState(() {
            _currentIndex = value;
          });
        }),
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: ((index) {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(_currentIndex);
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
