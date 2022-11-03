import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckoutSeedlings extends StatelessWidget {
  final List cartItems;
  const CheckoutSeedlings({Key? key, required this.cartItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seedling Checkout',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Expanded(child: ListView.builder(
            shrinkWrap: true,
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartItems[index]['name']),
                trailing: Text(cartItems[index]['quantity']),
              );
            },
          ))
        ],
      ),
    );
  }
}
