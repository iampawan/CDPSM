import 'package:vxstate/vxstate.dart';

import 'models/cart.dart';
import 'models/catalog.dart';

class MyStore extends VxStore {
  CatalogModel catalog;
  CartModel cart;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }

  @override
  String toString() {
    return "{total: ${cart.totalPrice}}";
  }
}

class LogInterceptor extends VxInterceptor {
  @override
  void afterMutation(VxMutation<VxStore> mutation) {
    print("Current State:" + mutation.store.toString());
  }

  @override
  bool beforeMutation(VxMutation<VxStore> mutation) {
    print("Prev State:" + mutation.store.toString());
    return true;
  }
}
