import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:pomangam_client_flutter/domains/cart/cart.dart';
import 'package:pomangam_client_flutter/domains/cart/item/cart_item.dart';
import 'package:pomangam_client_flutter/domains/store/store_quantity_orderable.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/repositories/store/store_repository.dart';
import 'package:provider/provider.dart';

class CartModel with ChangeNotifier {

  /// repository
  StoreRepository _storeRepository
  = Injector.appInstance.getDependency<StoreRepository>();

  /// model
  Cart cart = Cart();

  /// data
  bool isAllOrderable = true;
  bool isUpdatedOrderableStore = false;

  /// notifyListeners
  void notify() {
    notifyListeners();
  }

  /// model clear
  void clear({bool notify = true}) {
    cart.clear();
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> updateOrderableStore({
    @required int dIdx,
    @required int oIdx,
    @required DateTime oDate
  }) async {

    Set<int> idxesStore = idxesStoreInCartItem();
    if(idxesStore.isNotEmpty) {
      List<StoreQuantityOrderable> quantities = [];
      try {
        quantities = await _storeRepository.findQuantityOrderableByIdxes(
            dIdx: dIdx,
            oIdx: oIdx,
            oDate: DateFormat('yyyy-MM-dd').format(oDate),
            sIdxes: idxesStore.toList()
        );
      } catch(error) {
        print('[Debug] CartModel.updateOrderableStore Error - $error');
      }

      this.cart.items.forEach((cartItem) {
        cartItem.quantityOrderable = 0;
        for(StoreQuantityOrderable qo in quantities) {
          if(qo.idx == cartItem.store.idx) {
            cartItem.quantityOrderable = qo.quantityOrderable;
            break;
          }
        }
      });

      this.isAllOrderable = true;
      idxesStore.forEach((idxStore) {
        int totalQuantity = 0;
        List<CartItem> cartItems = cartItemsByIdxStore(idxStore);
        cartItems.forEach((item) => totalQuantity += item.quantity);
        bool isOrderable = (cartItems.first?.quantityOrderable ?? 0) - totalQuantity >= 0;
        if(!isOrderable) {
          this.isAllOrderable = false;
        }
        cartItems.forEach((item) {
          item.isOrderable = isOrderable;
        });
      });

    }
    isUpdatedOrderableStore = true;
    notifyListeners();
  }

  List<CartItem> cartItemsByIdxStore(int idxStore) {
    return this.cart.items.where((item) => item.store.idx == idxStore).toList();
  }

  Set<int> idxesStoreInCartItem() {
    return this.cart.items.map((cartItem) => cartItem.store.idx).toSet();
  }

  void changeIsUpdatedOrderableStore(bool tf) {
    this.isUpdatedOrderableStore = tf;
    notifyListeners();
  }

  void renewOrderableTime({bool notify = true}) {
    OrderTimeModel orderTimeModel = Get.context.read<OrderTimeModel>();
    cart.orderDate = orderTimeModel.userOrderDate;
    cart.orderTime = orderTimeModel.userOrderTime;
    if(notify) {
      notifyListeners();
    }
  }
}