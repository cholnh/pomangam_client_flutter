import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/product/product.dart';
import 'package:pomangam_client_flutter/domains/product/product_summary.dart';
import 'package:pomangam_client_flutter/domains/product/sub/category/product_sub_category.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';
import 'package:pomangam_client_flutter/domains/store/store_quantity_orderable.dart';
import 'package:pomangam_client_flutter/providers/store/store_summary_model.dart';
import 'package:pomangam_client_flutter/repositories/product/product_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomangam_client_flutter/_bases/key/shared_preference_key.dart' as s;

class ProductModel with ChangeNotifier {

  ProductRepository _productRepository;

  Product product;
  int quantity = 1;
  int quantityOrderable = 0;

  bool isProductFetched = false;
  bool isProductFetching = false;
  bool isProcessingLikeToggle = false;

  int idxProductSubCategory = 0;

  String userRecentRequirement = '맛있게 해주세요 ㅋㅋ';
  bool isUserRecentRequirement = false;

  ProductModel() {
    _productRepository = Injector.appInstance.getDependency<ProductRepository>();
  }

  Future<void> fetch({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx
  }) async {
    isProductFetching = true;
    try {
      this.product = await _productRepository.findByIdx(dIdx: dIdx, sIdx: sIdx, pIdx: pIdx);
      this.isProductFetched = true;
    } catch (error) {
      print('[Debug] ProductModel.fetch Error - $error');
      isProductFetching = false;
    }
    isProductFetching = false;
    notifyListeners();
  }

  void likeToggle({
    @required int dIdx,
    @required int sIdx,
    @required int pIdx
  }) async {
    if(isProcessingLikeToggle) return;
    isProcessingLikeToggle = true;
    try {
      bool isLike = await _productRepository.likeToggle(dIdx: dIdx, sIdx: sIdx, pIdx: pIdx);
      product.isLike = isLike;
      notifyListeners();
    } catch (error) {
      print('[Debug] ProductModel.likeToggle Error - $error');
    } finally {
      isProcessingLikeToggle = false;
    }
  }

  void setQuantityOrderable({
    @required int dIdx,
    @required int oIdx,
    @required DateTime oDate,
    @required int sIdx,
  }) async {
    List<StoreQuantityOrderable> qos = await Get.context.read<StoreSummaryModel>().fetchQuantityOrderable(
      dIdx: dIdx,
      oIdx: oIdx,
      oDate: oDate,
      sIdxes: List()..add(sIdx)
    );
    for(StoreQuantityOrderable qo in qos) {
      if(qo.idx == sIdx) {
        this.quantityOrderable = qo.quantityOrderable;
        break;
      }
    }
  }

  void changeIsProductFetched(bool tf) {
    this.isProductFetched = tf;
    notifyListeners();
  }

  void changeIdxProductSubCategory(int idxProductSubCategory) {
    this.idxProductSubCategory = idxProductSubCategory;
    notifyListeners();
  }

  void toggleProductSubIsSelected({ProductSubCategory productSubCategory, int subIdx, bool isRadio = false, bool isNotify = true}) {
    productSubCategory.productSubs.forEach((sub) {
      if(sub.idx == subIdx) {
        if(isRadio) {
          if(!sub.isSelected) {
            productSubCategory.selectedProductSub.add(sub);
          }
          sub.isSelected = true;
        } else {
          sub.isSelected = !sub.isSelected;
          if(sub.isSelected) {
            productSubCategory.selectedProductSub.add(sub);
          } else {
            productSubCategory.selectedProductSub.removeWhere((el) => el.idx == subIdx);
          }
        }
      } else {
        if(isRadio) {
          sub.isSelected = false;
          productSubCategory.selectedProductSub.removeWhere((el) => el.idx == sub.idx);
        }
      }
    });
    if(isNotify) {
      notifyListeners();
    }
  }

  void changeUpQuantity() {
    ++quantity;
    notifyListeners();
  }

  void changeDownQuantity() {
    if(quantity > 1) {
      --quantity;
      notifyListeners();
    } else {
      quantity = 1;
    }
  }

  int totalPrice() {
    int total = product?.salePrice ?? 0;
    product?.productSubCategories?.forEach((category) {
      total += category.totalSubPrice();
    });
    return total * quantity;
  }

  void toggleIsUserRecentRequirement() {
    this.isUserRecentRequirement = !isUserRecentRequirement;
    notifyListeners();
  }

  Future<String> loadUserRecentRequirement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userRecentRequirement = prefs.getString(s.userRecentRequirement);
    return this.userRecentRequirement;
  }

  void saveUserRecentRequirement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(s.userRecentRequirement, userRecentRequirement);
  }

  List<ProductSub> selectedSubs() {
    List<ProductSub> selectedSubs = List();
    product?.productSubCategories?.forEach((subCategory)
      => selectedSubs.addAll(subCategory.selectedProductSub));
    return selectedSubs;
  }

  void clear({bool notify = true}) {
    product = null;
    quantity = 1;
    isProductFetched = false;
    idxProductSubCategory = 0;
    isUserRecentRequirement = false;
    if(notify) {
      notifyListeners();
    }
  }
}