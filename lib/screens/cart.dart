import 'package:flutter/material.dart';
import 'package:catalog_app/models/cart.dart';
import 'package:vxstate/vxstate.dart';

import '../mystore.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.listen(context, to: [RemoveMutation]);
    var itemNameStyle =
        Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);
    final CartModel cart = (VxState.store as MyStore).cart;

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(
          Icons.done,
          color: Colors.white,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: Colors.white,
          ),
          onPressed: () => RemoveMutation(cart.items[index]),
        ),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartModel cart = (VxState.store as MyStore).cart;
    var hugeStyle = Theme.of(context)
        .textTheme
        .headline1
        .copyWith(fontSize: 48, color: Colors.white);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VxBuilder(
                builder: (ctx, _) {
                  return Text('\$${cart.totalPrice}', style: hugeStyle);
                },
                mutations: {RemoveMutation}),
            SizedBox(width: 24),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
