import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/domains/order/item/order_item_response.dart';
import 'package:pomangam_client_flutter/domains/order/order_response.dart';
import 'package:pomangam_client_flutter/views/pages/store/review/store_review_write_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';

class StoreReviewSelectPage extends StatelessWidget {

  final OrderResponse order;

  StoreReviewSelectPage({this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: '리뷰 선택',
        leadingIcon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('어느 음식점에 리뷰를 쓰실건가요?', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )),
                SizedBox(height: 30),
                for(int idxStore in _idxStores())
                  GestureDetector(
                    onTap: () =>  Get.to(StoreReviewWritePage(
                      idxesOrderItem: _idxesOrderItem(idxStore),
                      idxStore: idxStore,
                      nameStore: _nameStore(idxStore),
                      nameProducts: _nameProducts(idxStore)
                    )),
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${_nameStore(idxStore)}', style: TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          )),
                          SizedBox(height: 3),
                          Text('${_nameProducts(idxStore)}', style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[500]
                          ), maxLines: 3, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Set<int> _idxStores() {
    Set<int> idxStores = Set();
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite) {
        idxStores.add(item.idxStore);
      }
    }
    return idxStores;
  }

  List<int> _idxesOrderItem(int idxStore) {
    Set<int> idxItems = Set();
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite && item.idxStore == idxStore) {
        idxItems.add(item.idx);
      }
    }
    return idxItems.toList();
  }

  String _nameStore(int idxStore) {
    for(OrderItemResponse item in order.orderItems) {
      if(!item.reviewWrite && item.idxStore == idxStore) {
        return item.nameStore;
      }
    }
    return '';
  }

  String _nameProducts(int idxStore) {
    String nameProducts = '';
    for(int i=0; i<order.orderItems.length; i++) {
      OrderItemResponse item = order.orderItems[i];
      if(!item.reviewWrite && item.idxStore == idxStore) {
        nameProducts += '#${item.nameProduct}' + (i == order.orderItems.length - 1 ? '' : ' ');
      }
    }
    return nameProducts;
  }
}
