import 'package:flutter/widgets.dart';
import 'package:pomangam_client_flutter/domains/cart/item/cart_item.dart';
import 'package:pomangam_client_flutter/domains/coupon/coupon.dart';
import 'package:pomangam_client_flutter/domains/deliverysite/detail/delivery_detail_site.dart';
import 'package:pomangam_client_flutter/domains/order/time/order_time.dart';
import 'package:pomangam_client_flutter/domains/product/product.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';
import 'package:pomangam_client_flutter/domains/promotion/promotion.dart';
import 'package:pomangam_client_flutter/domains/store/store.dart';

class Cart {

  DateTime orderDate;

  OrderTime orderTime;

  DeliveryDetailSite detail;

  String subAddress;

  /// 사용 포인트
  int usingPoint = 0;

  /// 사용 쿠폰
  Coupon usingCouponCode;
  List<Coupon> usingCoupons = List();

  /// 사용 프로모션
  List<Promotion> usingPromotions = List();

  List<CartItem> items = List();

  /// 장바구니 초기화
  void clear() {
    usingPoint = 0;
    usingCouponCode = null;
    usingCoupons.clear();
    // usingPromotions.clear();
    items.clear();
  }

  /// 장바구니 아이템 추가
  void addItem({
    @required Store store,
    @required Product product,
    @required int quantity,
    @required List<ProductSub> subs,
    String requirement,
  }) {
    items.add(CartItem(
        idx: _generateIdx(),
        store: store,
        product: product,
        quantity: quantity,
        subs: subs,
        requirement: requirement
    ));
  }

  /// 장바구니 아이템 삭제
  void removeItem(CartItem removeItem) {
    items.removeWhere((CartItem el) => el.idx == removeItem.idx);
  }

  /// 쿠폰 리스트
  List<Coupon> getAllUsingCoupons() {
    List<Coupon> cpList = List();
    if(usingCouponCode != null) {
      cpList.add(usingCouponCode);
    }
    cpList.addAll(usingCoupons);
    return cpList;
  }

  /// 쿠폰 추가
  void addCoupon(Coupon coupon) {
    usingCoupons.clear(); // Todo. 중복방지 (기획이 미완성이라 일단 중복방지로 막아둠)
    usingCoupons.add(coupon);
  }

  /// 쿠폰 취소
  void cancelCoupon(Coupon coupon) {
    if(usingCouponCode != null && usingCouponCode.idx == coupon.idx) {
      usingCouponCode = null;
      return;
    }
    for(Coupon usingCoupon in usingCoupons) {
      if(usingCoupon.idx == coupon.idx) {
        usingCoupons.remove(usingCoupon);
        return;
      }
    }
  }

  /// 쿠폰 할인 가격
  int discountPriceUsingCoupons() {
    int discountPrice = 0;
    getAllUsingCoupons().forEach((usingCoupon) => discountPrice += usingCoupon.discountCost);
    return discountPrice;
  }

  /// 최종 결제 가격
  int totalPrice() {
    int q = 0;
    items.forEach((item) {
      q += item.quantity;
    });
    int totalDiscount = 0;
    totalDiscount += usingPoint;
    getAllUsingCoupons().forEach((usingCoupon)
    => totalDiscount += usingCoupon.isValid() ? usingCoupon.discountCost : 0);
    usingPromotions.forEach((usingPromotion)
    => totalDiscount += usingPromotion.isValid() ? usingPromotion.discountCost * q : 0);
    int totalPrice = itemsPrice() - totalDiscount;
    return totalPrice < 0 ? 0 : totalPrice;
  }

  /// 장바구니 아이템 총 가격
  int itemsPrice() {
    int total = 0;
    items?.forEach((item) {
      total += item?.totalPrice() ?? 0;
    });
    return total;
  }

  List<CartItem> cartItemsByIdxStore(int idxStore) {
    return items.where((item) => item.store.idx == idxStore).toList();
  }

  Set<int> idxesStoreInCartItem() {
    return items.map((cartItem) => cartItem.store.idx).toSet();
  }

  int _generateIdx() {
    int max = 0;
    items?.forEach((item) => max = item.idx > max ? item.idx : max);
    return max + 1;
  }

  bool isEmpty() {
    return items.isEmpty;
  }

  bool isNotEmpty() {
    return items.isNotEmpty;
  }

  bool isOrderableDateTime() {
    DateTime now = DateTime.now();
    if(orderDate.year == now.year && orderDate.month == now.month && orderDate.day == now.day) {
      return orderTime.getOrderEndDateTime().isAfter(now);
    } else if(orderDate.year > now.year || orderDate.month > now.month || orderDate.day > now.day) {
      return true;
    } else {
      return false;
    }
  }
}