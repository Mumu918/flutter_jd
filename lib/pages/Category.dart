import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Config.dart';
import 'package:flutter_jd/pages/ProductList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeft(isInit: true);
  }

  int _selectIndex = 0;
  List _leftList = [];
  List _rightList = [];
  bool _rightLoading = true;

  _getLeft({bool isInit = false}) async {
    var url = Uri.https(Config.admin, 'api/pcate');
    var res = await http.get(url);
    var list = json.decode(res.body)['result'];
    if (mounted) {
      setState(() {
        _leftList = list;
        if (isInit) {
          _getRight(_leftList[0]['_id']);
        }
      });
    }
  }

  _getRight(String id) async {
    if (mounted) {
      setState(() {
        _rightLoading = true;
      });
    }
    var url = Uri.https(Config.admin, 'api/pcate', {'pid': id});
    var res = await http.get(url);
    var list = json.decode(res.body)['result'];
    if (mounted) {
      setState(() {
        _rightList = list;
        _rightLoading = false;
      });
    }
  }

  Widget getRightWidget() {
    if (_rightLoading) {
      return const CupertinoActivityIndicator();
    } else {
      return Container(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(10),
          ),
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          height: double.infinity,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.2,
                crossAxisSpacing: ScreenUtil().setWidth(10),
                mainAxisSpacing: ScreenUtil().setWidth(10),
              ),
              itemCount: _rightList.length,
              itemBuilder: ((context, index) {
                // 将url中的反斜杠转换为斜杠
                String? pic = _rightList[index]['pic'];
                pic = pic?.replaceAll('\\', '/');
                pic = '${Config.baseUrl}/$pic';
                return InkWell(
                  onTap: () {
                    // 跳转到商品列表，传递商品分类id
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            ProductList(id: _rightList[index]['_id']))));
                  },
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Text(
                              _rightList[index]['title'],
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ],
                  ),
                );
              })));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: ScreenUtil().setWidth(200),
            height: double.infinity,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                String title = _leftList[index]['title'];

                return Column(
                  children: [
                    InkWell(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              _selectIndex = index;
                            });
                          }
                          _getRight(_leftList[_selectIndex]['_id']);
                        },
                        child: Container(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(84),
                            color: _selectIndex == index
                                ? const Color.fromRGBO(240, 246, 246, 0.9)
                                : Colors.white,
                            padding:
                                EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                            child: Center(
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                              ),
                            ))),
                    const Divider(
                      height: 1,
                    )
                  ],
                );
              }),
              itemCount: _leftList.length,
            )),
        Expanded(flex: 1, child: getRightWidget()),
      ],
    );
  }
}
