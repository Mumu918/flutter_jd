import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: ((context) {
              return Container(
                child: Text('!!!'),
              );
            }));
      },
      child: const Text('偷着乐.'),
    ));
  }
}
