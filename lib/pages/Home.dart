import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _swiperList = [
    Image.network(
      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg-pre.ivsky.com%2Fimg%2Ftupian%2Fpre%2F201610%2F31%2Fyewai_huli-011.jpg&refer=http%3A%2F%2Fimg-pre.ivsky.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663138804&t=3255b0d361c8fab1bfbecac666d2745b',
      fit: BoxFit.cover,
    ),
    Image.network(
        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg9.51tietu.net%2Fpic%2F2019-091223%2Fmc1nhpj02jtmc1nhpj02jt.jpg&refer=http%3A%2F%2Fimg9.51tietu.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663138878&t=b1ef5bdec9e9cbf61ae14e873da3bc4d',
        fit: BoxFit.cover),
    Image.network(
        'https://img2.baidu.com/it/u=4208510731,1764525864&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=333',
        fit: BoxFit.cover)
  ];
  Widget swiperWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Swiper(
        itemBuilder: (context, index) {
          return _swiperList[index];
        },
        itemCount: 3,
        pagination: const SwiperPagination(),
        autoplay: true,
      ),
    );
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

  // 热门商品
  Widget hotProductListWidget() {
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

  Widget recProductItemWidget() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
      width: (ScreenUtil().screenWidth - 30) / 2,
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Image.network(
          'https://www.mms591.com/www.mms591.com-photo/2013041016/1-1304101A102.jpg',
          fit: BoxFit.cover,
          height: ScreenUtil().setHeight(280),
          width: double.infinity,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          child: const Text(
            '狐属（学名：Vulpes）：体长为45-90厘米，尾长25-60厘米，体重2-10千克，最大的超过15千克，雌兽体形比雄兽略小。体型中等、匀称，四肢修长，趾行性，利于快速奔跑。头腭尖形，颜面部长，鼻端突出，耳尖且直立，嗅觉灵敏，听觉发达。犬齿及裂齿发达；上臼齿具明显齿尖，下臼齿内侧具一小齿尖及后跟尖；臼齿齿冠直径大于外侧门齿高度；齿式为。毛粗而长，一般不具花纹。爪粗而钝，略能伸缩。尾多毛，一般较发达。',
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
                '￥183.3',
                style: TextStyle(
                    color: Colors.red, fontSize: ScreenUtil().setSp(30)),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥208.3',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: ScreenUtil().setSp(25),
                      decoration: TextDecoration.lineThrough),
                )),
          ],
        )
      ]),
    );
  }

  // 推荐商品
  Widget recProductListWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          recProductItemWidget(),
          recProductItemWidget(),
          recProductItemWidget(),
          recProductItemWidget(),
          recProductItemWidget(),
        ],
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
