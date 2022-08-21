import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Config.dart';
import 'package:flutter_jd/pages/model/ProductModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './model/FocusModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _getSwiperData(); // 轮播图
      _getHotProductData(); // 猜你喜欢
    }
  }

  List<FocusItemModel> _swiperList = [];

  // 获取轮播图数据
  _getSwiperData() async {
    var url = Uri.https(Config.admin, 'api/focus');
    var res = await http.get(url);
    var focusList = FocusModel.fromJson(json.decode(res.body));
    if (mounted) {
      setState(() {
        _swiperList = focusList.result!;
      });
    }
  }

  List<ProductItemModel> _hotProductList = [];

  // 获取猜你喜欢数据
  _getHotProductData() async {
    var url = Uri.https(Config.admin, 'api/plist', {'is_hot': '1'});
    var res = await http.get(url);
    var productList = ProductModel.fromJson(json.decode(res.body));
    if (mounted) {
      setState(() {
        _hotProductList = productList.result!;
      });
    }
  }

  // 轮播图
  Widget swiperWidget() {
    if (_swiperList.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
          itemBuilder: (context, index) {
            // 将url中的反斜杠转换为斜杠
            String? pic = _swiperList[index].pic;
            pic = pic?.replaceAll('\\', '/');
            pic = '${Config.baseUrl}/$pic';
            return Image.network(
              pic,
              fit: BoxFit.cover,
            );
          },
          itemCount: _swiperList.length,
          pagination: const SwiperPagination(),
          autoplay: true,
          onTap: (index) {
            print('$index');
          },
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Swiper(
          itemBuilder: (context, index) {
            return const CupertinoActivityIndicator();
          },
          itemCount: 1,
          pagination: const SwiperPagination(),
          autoplay: true,
        ),
      );
    }
  }

  Widget titleWidget(value) {
    return Container(
      height: ScreenUtil().setHeight(30),
      margin: EdgeInsets.only(left: ScreenUtil().setHeight(30)),
      padding: EdgeInsets.only(left: ScreenUtil().setHeight(30)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenUtil().setHeight(10)))),
      child: Text(
        value,
        style:
            TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(26)),
      ),
    );
  }

  // 猜你喜欢
  Widget hotProductListWidget() {
    if (_hotProductList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: ScreenUtil().setHeight(150),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            String sPic = _hotProductList[index].sPic!;
            sPic = sPic.replaceAll('\\', '/');
            sPic = '${Config.baseUrl}/$sPic';
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                  child: Image.network(
                    sPic,
                    fit: BoxFit.cover,
                    width: ScreenUtil().setWidth(100),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                  height: ScreenUtil().setHeight(40),
                  child: Text(
                    '￥${_hotProductList[index].price}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          }),
          scrollDirection: Axis.horizontal,
          itemCount: _hotProductList.length,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: ScreenUtil().setHeight(150),
        child: ListView.builder(
          itemBuilder: ((context, index) => Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    child: Image.network(
                      'https://img2.baidu.com/it/u=1529021379,1624541816&fm=253&fmt=auto&app=138&f=JPEG?w=200&h=200',
                      fit: BoxFit.cover,
                      width: ScreenUtil().setWidth(100),
                    ),
                  ),
                  Text('第$index条')
                ],
              )),
          scrollDirection: Axis.horizontal,
          itemCount: 20,
        ),
      );
    }
  }

  // 推荐商品详情
  List<Widget> _recProductItemListWidget() {
    List<Widget> list = [];
    for (var i = 0; i < _hotProductList.length; i++) {
      ProductItemModel product = _hotProductList[i];
      String pic = product.pic!.replaceAll('\\', '/');
      pic = '${Config.baseUrl}/$pic';
      list.add(Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
        width: (ScreenUtil().screenWidth - 30) / 2,
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          Image.network(
            pic,
            fit: BoxFit.cover,
            height: ScreenUtil().setHeight(280),
            width: double.infinity,
          ),
          Container(
            height: ScreenUtil().setHeight(80),
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            child: Text(
              product.title!,
              maxLines: 2,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '￥${product.price}',
                  style: TextStyle(
                      color: Colors.red, fontSize: ScreenUtil().setSp(30)),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '￥${product.oldPrice}',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: ScreenUtil().setSp(25),
                        decoration: TextDecoration.lineThrough),
                  )),
            ],
          ),
        ]),
      ));
    }
    if (_hotProductList.isNotEmpty) {
      return list;
    } else {
      return [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1)),
          width: (ScreenUtil().screenWidth - 30) / 2,
          padding: const EdgeInsets.all(5),
          child: Column(children: [
            Image.network(
              'https://img1.baidu.com/it/u=2142811971,206741594&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1660755600&t=6e874d7fadf5e141ab80cabbdd10d268',
              fit: BoxFit.cover,
              height: ScreenUtil().setHeight(280),
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              child: const Text(
                '加载中...',
                maxLines: 2,
                style: TextStyle(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '￥0.00',
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenUtil().setSp(30)),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '￥0.00',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: ScreenUtil().setSp(25),
                          decoration: TextDecoration.lineThrough),
                    )),
              ],
            )
          ]),
        )
      ];
    }
  }

  // 推荐商品
  Widget recProductListWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: _recProductItemListWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      swiperWidget(),
      SizedBox(
        height: ScreenUtil().setWidth(20),
      ),
      titleWidget('猜你喜欢'),
      SizedBox(
        height: ScreenUtil().setWidth(20),
      ),
      hotProductListWidget(),
      SizedBox(
        height: ScreenUtil().setWidth(20),
      ),
      titleWidget('热门推荐'),
      SizedBox(
        height: ScreenUtil().setWidth(20),
      ),
      recProductListWidget()
    ]);
  }
}
