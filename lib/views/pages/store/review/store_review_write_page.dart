import 'dart:typed_data';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pomangam_client_flutter/_bases/util/toast_utils.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/store/review/store_review_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:provider/provider.dart';

class StoreReviewWritePage extends StatefulWidget {

  final List<int> idxesOrderItem;
  final int idxStore;
  final String nameStore;
  final String nameProducts;

  StoreReviewWritePage({this.idxesOrderItem, this.idxStore, this.nameStore, this.nameProducts});

  @override
  _StoreReviewWritePageState createState() => _StoreReviewWritePageState();
}

class _StoreReviewWritePageState extends State<StoreReviewWritePage> {
  final TextEditingController _controller = TextEditingController();
  List<Asset> images = List<Asset>();
  bool _isAnonymous = false;
  double _star = 0;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: context.watch<StoreReviewModel>().isSaving,
      child: Scaffold(
        appBar: BasicAppBar(
          title: '${widget.nameStore}',
          leadingIcon: const Icon(CupertinoIcons.back, size: 20, color: Colors.black),
          actions: [
            GestureDetector(
              onTap: _onSave,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Text('완료', style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor
                  )),
                ),
              ),
            ),
            SizedBox(width: 15)
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.center,
                  child: Text('${widget.nameProducts}', style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.headline1.color,
                    fontWeight: FontWeight.bold
                  ), maxLines: 3, overflow: TextOverflow.ellipsis),
                ),
                SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: RatingBar(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    glow: false,
                    itemSize: 25,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        this._star = rating;
                      });
                    },
                  )
                ),
                GestureDetector(
                  onTap: _toggleCheckbox,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAnonymous,
                      ),
                      Text('익명', style: TextStyle(
                        fontSize: 14,
                        color: Colors.black
                      ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.grey[100],
                  height: 200,
                  child: TextFormField(
                    scrollPhysics: BouncingScrollPhysics(),
                    controller: _controller,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: '솔직한 리뷰를 작성해주세요!'
                    )
                  ),
                ),
                SizedBox(height: 15),
                _imageWidgets(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageWidgets() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _loadAssets,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: Container(
                  height: 70,
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.photo_camera, size: 40, color: Colors.grey[600]),
                      Text('사진 ${images.length}/5', style: TextStyle(
                          fontSize: 13,
                          color: Colors.black
                      )),
                      SizedBox(height: 5)
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey[500],
                          width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(3)
                  ),
                ),
              ),
            ),
            for(int i=0; i<images.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: Badge(
                  animationType: BadgeAnimationType.fade,
                  toAnimate: false,
                  elevation: 0.0,
                  showBadge: true,
                  badgeContent: GestureDetector(
                    onTap: () => _deleteImage(i),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.remove_circle, size: 22, color: Colors.grey[400])
                    ),
                  ),
                  badgeColor: Colors.transparent,
                  position: BadgePosition.topEnd(top: -15, end: -12),
                  child: Container(
                    height: 70,
                    width: 70,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey[300],
                            width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child: AssetThumb(
                      asset: images[i],
                      width: 70,
                      height: 70,
                      spinner: SizedBox(
                          width: 50,
                          height: 50,
                          child: CupertinoActivityIndicator()
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _toggleCheckbox() {
    setState(() {
      this._isAnonymous = !_isAnonymous;
    });
  }

  void _onSave() async {
    StoreReviewModel storeReviewModel = context.read();
    if(storeReviewModel.isSaving) return;

    if(_controller.text.isEmpty) {
      DialogUtils.dialog(context, '리뷰를 입력해주세요.');
      return;
    }
    if(_star == 0) {
      DialogUtils.dialog(context, '별점을 선택해주세요.');
      return;
    }

    try {
      storeReviewModel.lock();
      await storeReviewModel.save(
        dIdx: context.read<DeliverySiteModel>().userDeliverySite.idx,
        sIdx: widget.idxStore,
        isAnonymous: _isAnonymous,
        contents: _controller.text,
        star: _star.toInt(),
        productName: widget.nameProducts,
        idxesOrderItem: widget.idxesOrderItem,
        multipartFiles: await _multipartFiles()
      );
      ToastUtils.showToast();
    } catch(error) {
      print(error);
      ToastUtils.showToast(
        msg: '작성에 실패하였습니다.'
      );
    } finally {
      storeReviewModel.unlock();
    }

    context.read<OrderInfoModel>().fetchToday(isForceUpdate: true);
    context.read<OrderInfoModel>().fetchAll(isForceUpdate: true);

    Get.until((route) => route.isFirst);
  }

  Future<List<MultipartFile>> _multipartFiles() async {
    List<MultipartFile> multipartFiles = List();
    for(int i=0; i<images.length; i++) {
      Asset asset = images[i];
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: '${widget.idxStore}-$i.jpg',
        contentType: MediaType("image", "jpg"),
      );
      multipartFiles.add(multipartFile);
    }
    return multipartFiles;
  }

  Future<void> _loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#dddddd",
          actionBarTitle: "리뷰 사진",
          allViewTitle: "모든 사진",
          useDetailsView: false,
          selectCircleStrokeColor: "#eeeeee",
          statusBarColor: "#000000"
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  void _deleteImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }
}