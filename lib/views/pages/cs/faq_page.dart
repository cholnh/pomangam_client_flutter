import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/domains/faq/faq.dart';
import 'package:pomangam_client_flutter/domains/faq/faq_category.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/faq/faq_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';
import 'package:pomangam_client_flutter/views/widgets/cs/faq/faq_item_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/user_info/user_info_category_title_widget.dart';
import 'package:provider/provider.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {

  @override
  void initState() {
    _init(notify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FaqModel faqModel = context.watch<FaqModel>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: BasicAppBar(
        title: '자주 묻는 질문',
        leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black),
        elevation: 1.0,
      ),
      body: SafeArea(
        child: faqModel.isFetching
        ? _loading()
        : CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: _slivers(faqModel.faqCategories),
        ),
      ),
    );
  }

  void _init({bool notify = true}) async {
    Get.context.read<FaqModel>()
      ..clear(notify: notify)
      ..fetchAll(dIdx: Get.context.read<DeliverySiteModel>().userDeliverySite.idx);
  }

  Widget _loading() {
    return Center(child: CupertinoActivityIndicator());
  }

  List<Widget> _slivers(List<FaqCategory> faqCategories) {
    List<Widget> slivers = List();

    faqCategories.forEach((faqCategory) {
      slivers.add(UserInfoCategoryTitleWidget(title: faqCategory.title));
      for(var i=0; i<faqCategory.faqs.length; i++) {
        Faq faq = faqCategory.faqs[i];
        slivers.add(FaqItemWidget(
          title: faq.title,
          contents: faq.contents,
          isLast: i == faqCategory.faqs.length - 1,
        ));
      }
    });
    return slivers;
  }
}
