import 'package:flutter/material.dart';
import 'package:catalog_app/models/cart.dart';

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

class _CartList extends StatefulWidget {
  @override
  __CartListState createState() => __CartListState();
}

class __CartListState extends State<_CartList> {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle =
        Theme.of(context).textTheme.headline6.copyWith(color: Colors.white);
    //TODO 4 - Get Cart
    var cart = CartModel();

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
          onPressed: () {
            cart.remove(cart.items[index]);
            setState(() {});
          },
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
            // TODO 5 - Consume Cart
            Text('\$${CartModel().totalPrice}', style: hugeStyle),
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
