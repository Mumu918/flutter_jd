import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class ProductList extends StatefulWidget {
  final String id;
  const ProductList({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List _productList = [];

  int _page = 1;

  bool _flag = true;

  final ScrollController _scrollController = ScrollController();

  final int _pageSize = 8;

  bool _isBottom = false;

  _getProductListData() async {
    setState(() {
      _flag = false;
    });

    var url = Uri.https(Config.admin, 'api/plist', {
      'cid': widget.id,
      'page': _page.toString(),
      'pageSize': _pageSize.toString()
    });
    var res = await http.get(url);
    var list = json.decode(res.body)['result'];
    _page++;

    if (mounted) {
      setState(() {
        _productList.addAll(list);
        _flag = true;
        if (list.length < _pageSize) {
          _isBottom = true;
          print(_isBottom);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _getProductListData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (_flag && !_isBottom) {
          _getProductListData();
        }
      }
    });
  }

  Widget _tagWidget(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15, color: Color.fromARGB(221, 39, 38, 38)),
      ),
    );
  }

  Widget _getProductListItemWidget(int index) {
    String? pic = _productList[index]['pic'];
    pic = pic?.replaceAll('\\', '/');
    pic = '${Config.baseUrl}/$pic';

    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  pic,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_productList[index]['title']}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              _tagWidget('4g'),
                              const SizedBox(
                                width: 10,
                              ),
                              _tagWidget('126GB')
                            ],
                          ),
                          Text(
                            '￥${_productList[index]['price']}',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            const Divider(),
            _moreWiget(index)
          ],
        ));
  }

  Widget _moreWiget(int index) {
    if (index == _productList.length - 1) {
      if (_isBottom) {
        return const SizedBox(
          height: 20,
          child: Text('完了'),
        );
      } else {
        return const CupertinoActivityIndicator();
      }
    } else {
      return const Text('');
    }
  }

  Widget _comprehensive() {
    if (_productList.isEmpty) {
      return const CupertinoActivityIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return _getProductListItemWidget(index);
          }),
          itemCount: _productList.length,
          controller: _scrollController,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_upward_sharp),
          onPressed: () {
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
          },
        ),
        appBar: AppBar(
          title: const Text('商品列表'),
          centerTitle: true,
          backgroundColor: Colors.red,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: const [
              Tab(
                text: '综合',
              ),
              Tab(
                text: '销量',
              ),
              Tab(
                text: '价格',
              )
            ],
            controller: _tabController,
          ),
          leading: new IconButton(
            tooltip: '返回上一页',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              //_nextPage(-1);
            },
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.bento_rounded),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
        endDrawer: const Drawer(
          child: SizedBox(child: Text('事与愿违')),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_comprehensive(), Text('1'), Text('2')],
        ));
  }
}
