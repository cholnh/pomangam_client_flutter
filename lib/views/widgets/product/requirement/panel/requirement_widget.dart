import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/domains/product/product_type.dart';
import 'package:pomangam_client_flutter/domains/product/sub/product_sub.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';

class RequirementWidget extends StatefulWidget {

  @override
  _RequirementWidgetState createState() => _RequirementWidgetState();
}

class _RequirementWidgetState extends State<RequirementWidget> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = context.watch();
    bool isOrderable = productModel.quantityOrderable >= productModel.quantity;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]
      ),
      margin: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('가게 사장님에게', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                Padding(padding: EdgeInsets.only(bottom: 8.0)),
                TextField(
                  controller: _textEditingController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: '예) 오이 빼주세요.',
                    hintStyle: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)),
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel, size: 18.0),
                      onPressed: () => WidgetsBinding.instance.addPostFrameCallback((_) => _textEditingController.clear()),
                    )
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                  keyboardType: TextInputType.text,
                ),
                Consumer<ProductModel>(
                  builder: (_, model, child) {
                    if (model.userRecentRequirement != null && model.userRecentRequirement.trim().isNotEmpty) {
                      return GestureDetector(
                      onTap: () => model.toggleIsUserRecentRequirement(),
                      child: Row(
                        children: <Widget>[
                          Checkbox(value: model.isUserRecentRequirement),
                          Text('${model.userRecentRequirement}', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5)))
                        ],
                      ),
                    );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Container(
                color: Theme.of(Get.context).primaryColor,
                width: MediaQuery.of(context).size.width,
                height: 53.0,
                child: Center(
                  child: Text('확인', style: TextStyle(color: Theme.of(Get.context).backgroundColor, fontWeight: FontWeight.bold, fontSize: 15.0)),
                ),
              ),
              onTap: _onDialogSelected // isOrderable ? _onDialogSelected : _onFail,
            ),
          )
        ],
      ),
    );
  }

  void _onFail() {
    DialogUtils.dialog(context, '주문 가능한 수량이 없습니다.');
  }

  void _onDialogSelected() {
    ProductModel productModel = context.read();
    List<ProductSub> selectedSubs = productModel.selectedSubs();

    if(!_isValidCustomProduct(selectedSubs)) {
      DialogUtils.dialog(context, '모든 칸의 음식을 채워주세요.');
      return;
    }

    context.read<CartModel>()
      ..cart.addItem(
        store: context.read<StoreModel>().store,
        product: productModel.product,
        quantity: productModel.quantity,
        subs: selectedSubs,
        requirement: _requirementAndSaveIt(),
      )
      ..notify();

    Navigator.pop(context);

    ToastUtils.showToast(
        msg: "카트에 추가되었습니다."
    );
  }

  bool _isValidCustomProduct(List<ProductSub> selectedSubs) {
    ProductModel productModel = context.read();
    int n = 0;
    switch(productModel.product.productType) {
      case ProductType.CUSTOMIZING_2: n = 2; break;
      case ProductType.CUSTOMIZING_3: n = 3; break;
      case ProductType.CUSTOMIZING_4: n = 4; break;
      case ProductType.CUSTOMIZING_5: n = 5; break;
      case ProductType.CUSTOMIZING_6: n = 6; break;
      default: return true;
    }
    return selectedSubs.length == n;
  }

  String _requirementAndSaveIt() {
    ProductModel productModel = context.read<ProductModel>();
    String userInput = _textEditingController?.text ?? '';
    String requirement = userInput;
    if(productModel.isUserRecentRequirement) {
      requirement += (userInput.isEmpty ? '' : ', ') + productModel.userRecentRequirement;
    }
    if(userInput.isNotEmpty) {
      productModel
        ..userRecentRequirement = userInput
        ..saveUserRecentRequirement();
    }
    return requirement;
  }
}
