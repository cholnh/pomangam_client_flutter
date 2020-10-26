import 'package:pomangam_client_flutter/providers/advertisement/advertisement_model.dart';
import 'package:pomangam_client_flutter/providers/cart/cart_model.dart';
import 'package:pomangam_client_flutter/providers/coupon/coupon_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/delivery_site_model.dart';
import 'package:pomangam_client_flutter/providers/deliverysite/detail/delivery_detail_site_model.dart';
import 'package:pomangam_client_flutter/providers/event/event_model.dart';
import 'package:pomangam_client_flutter/providers/faq/faq_model.dart';
import 'package:pomangam_client_flutter/providers/help/help_model.dart';
import 'package:pomangam_client_flutter/providers/home/home_contents_view_model.dart';
import 'package:pomangam_client_flutter/providers/home/home_view_model.dart';
import 'package:pomangam_client_flutter/providers/notice/notice_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_info_model.dart';
import 'package:pomangam_client_flutter/providers/order/order_model.dart';
import 'package:pomangam_client_flutter/providers/order/time/order_time_model.dart';
import 'package:pomangam_client_flutter/providers/payment/payment_model.dart';
import 'package:pomangam_client_flutter/providers/payment/pg_model.dart';
import 'package:pomangam_client_flutter/providers/point/point_model.dart';
import 'package:pomangam_client_flutter/providers/policy/policy_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_summary_model.dart';
import 'package:pomangam_client_flutter/providers/product/product_view_model.dart';
import 'package:pomangam_client_flutter/providers/product/sub/product_sub_category_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_up_model.dart';
import 'package:pomangam_client_flutter/providers/sort/home_sort_model.dart';
import 'package:pomangam_client_flutter/providers/store/review/StoreReviewSortModel.dart';
import 'package:pomangam_client_flutter/providers/store/review/store_review_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_product_category_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_summary_model.dart';
import 'package:pomangam_client_flutter/providers/store/store_view_model.dart';
import 'package:pomangam_client_flutter/providers/tab/tab_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => TabModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => SignUpModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => SignInModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => DeliverySiteModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => DeliveryDetailSiteModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => OrderTimeModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => StoreSummaryModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => StoreModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => StoreProductCategoryModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => ProductModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => ProductSummaryModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => ProductSubCategoryModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => AdvertisementModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => CartModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => PaymentModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => PolicyModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => PointModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => ProductViewModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => StoreViewModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => HomeSortModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => CouponModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => OrderModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => NoticeModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => EventModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => StoreReviewSortModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => PgModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => OrderInfoModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => HomeViewModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => HomeContentsViewModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => FaqModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => HelpModel(), lazy: true),
  ChangeNotifierProvider(create: (_) => StoreReviewModel(), lazy: true)

];