import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:catalog_app/models/cart.dart';
import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/widgets/appbar.dart';

class MyCatalog extends StatefulWidget {
  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    var jsonData = await rootBundle.loadString('assets/catalog.json');
    dynamic decodedData = jsonDecode(jsonData);
    CatalogModel.items = List<Item>.from(((decodedData)["products"])
        .map((e) => Item.fromJson(jsonEncode(e)))).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MyListItem(index),
              childCount: CatalogModel.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatefulWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  __AddButtonState createState() => __AddButtonState();
}

class __AddButtonState extends State<_AddButton> {
  @override
  Widget build(BuildContext context) {
    //TODO 2 - Find inCart or not

    final isInCart = CartModel().items.contains(widget.item);

    return TextButton(
      onPressed: isInCart
          ? null
          : () {
              //TODO 3 - Get Cart
              var cart = CartModel();
              cart.catalog = CatalogModel();
              cart.add(widget.item);
              setState(() {});
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart ? Icon(Icons.check, semanticLabel: 'ADDED') : Text('ADD'),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = CatalogModel.items[index];
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(item.image),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
