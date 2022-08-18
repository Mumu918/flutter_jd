import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int _selectIndex = 0;
  double _screenWidth = 0;
  @override
  void initState() {
    super.initState();
    print(_screenWidth);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _screenWidth = ScreenUtil().scaleWidth;
    });

    return Row(
      children: [
        Container(
            width: ScreenUtil().setWidth(200),
            height: double.infinity,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            _selectIndex = index;
                          });
                        },
                        child: Container(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(50),
                            child: Center(
                              child: Text(
                                'is $index',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _selectIndex == index
                                      ? Colors.pink
                                      : Colors.black87,
                                ),
                              ),
                            ))),
                    Divider(
                      color:
                          _selectIndex == index ? Colors.pink : Colors.black87,
                    )
                  ],
                );
              }),
              itemCount: 18,
            )),
        Expanded(
          flex: 1,
          child: SizedBox(
              height: double.infinity,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.2,
                    crossAxisSpacing: ScreenUtil().setWidth(10),
                    mainAxisSpacing: ScreenUtil().setWidth(10),
                  ),
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              'https://img0.baidu.com/it/u=3085690425,3847123260&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1660842000&t=5c5505813673d91db9fda6df725d3aee',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                color: Colors.pink[200],
                                child: Text('111'),
                              ))
                        ],
                      ),
                    );
                  }))),
        ),
      ],
    );
  }
}
