import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final String id;
  const ProductList({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
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

  Widget _getProductListItemWidget() {
    return Container(
        // padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black45))),
        child: Row(
          children: [
            Image.network(
              'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.chinanews.com.cn%2Fcul%2F2010%2F09-20%2FU136P4T8D2546795F107DT20100920181537.jpg&refer=http%3A%2F%2Fwww.chinanews.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663741804&t=272b01ab46812c10b380672cd73b05a4',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '做奴隶虽然不幸，但并不可怕，因为知道挣扎，毕竟还有挣脱的希望；若是从奴隶生活中寻出美来，赞叹、陶醉，就是万劫不复的奴才了。',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
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
                      const Text(
                        '￥990.45',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  Widget _comprehensive() {
    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: ((context, index) {
          return _getProductListItemWidget();
        }),
        itemCount: 10,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_comprehensive(), Text('1'), Text('2')],
        ));
  }
}
