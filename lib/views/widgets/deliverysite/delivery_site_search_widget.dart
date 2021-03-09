import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:provider/provider.dart';

class DeliverySiteSearchWidget extends StatelessWidget {
  final isFirst;

  DeliverySiteSearchWidget(this.isFirst);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (isFirst ? 21 : 80),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: TextField(
        style: TextStyle(fontSize: 15.0, color: Theme.of(context).textTheme.headline1.color),
        keyboardType: TextInputType.text,
        cursorColor: Colors.black.withOpacity(0.5),
        autofocus: false,
        textInputAction: TextInputAction.search,
        textAlignVertical: kIsWeb ? TextAlignVertical.center : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: kIsWeb ? 5 : 0),
          border: InputBorder.none,
          hintText: '건물명으로 배달지역 검색',
          prefixIcon: IconTheme(
            data: IconThemeData(color: Colors.black.withOpacity(0.5), size: 20.0),
            child: Icon(Icons.search, color: Colors.black.withOpacity(0.5), size: 20),
          )),
        onChanged: _search,
      ),
    );
  }

  void _search(String text) {
    Get.context.read<DeliverySiteModel>().search(query: text);
  }
}