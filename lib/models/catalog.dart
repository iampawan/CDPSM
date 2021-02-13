import 'dart:convert';

import 'package:flutter/material.dart';

class CatalogModel {
  static final catalogModel = CatalogModel._internal();

  CatalogModel._internal();

  factory CatalogModel() => catalogModel;

  static List<Item> items = [];

  /// Get item by [id].
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    return items[position];
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final String desc;
  final Color color;
  final String image;
  final num price;

  Item(
    this.id,
    this.name,
    this.desc,
    this.image,
    this.price,
  ) : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Item &&
        o.id == id &&
        o.name == name &&
        o.desc == desc &&
        o.color == color &&
        o.image == image &&
        o.price == price;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'color': color?.value,
      'image': image,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Item(
      map['id'] as int,
      map['name'] as String,
      map['desc'] as String,
      map['image'] as String,
      map['price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, color: $color, image: $image, price: $price)';
  }
}
