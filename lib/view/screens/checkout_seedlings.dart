import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class CheckoutSeedlings extends StatefulWidget {
  final List<Map> cartItems;
  final String name;
  final String loc;
  const CheckoutSeedlings(
      {Key? key,
      required this.cartItems,
      required this.name,
      required this.loc})
      : super(key: key);

  @override
  State<CheckoutSeedlings> createState() => _CheckoutSeedlingsState();
}

class _CheckoutSeedlingsState extends State<CheckoutSeedlings> {
  @override
  Widget build(BuildContext context) {
    var cart = widget.cartItems.removeAt(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seedling Checkout',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        children: [
          Text(
            widget.name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          Text(
            widget.loc,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.cartItems[index]['name']),
                trailing: Text(widget.cartItems[index]['quantity']),
              );
            },
          ))
        ],
      ),
    );
  }
}
