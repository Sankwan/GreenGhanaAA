import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:tiktok_yt/view/screens/auth/signup_screen.dart';
import 'package:tiktok_yt/view/screens/request_status.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class CheckoutSeedlings extends StatefulWidget {
  final List<Map> cartItems;
  final String name;
  final String loc;
  final String number;
  const CheckoutSeedlings(
      {Key? key,
      required this.cartItems,
      required this.name,
      required this.number,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          Text(
            widget.loc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            widget.number,
            textAlign: TextAlign.center,
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
          )),
         const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>const RequestStatus()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  'Confirm',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
