import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/_bases/initalizer/initializer.dart';
import 'package:pomangam_client_flutter/_bases/network/api/api.dart';
import 'package:pomangam_client_flutter/_bases/network/repository/authorization_repository.dart';
import 'package:pomangam_client_flutter/_bases/network/repository/resource_repository.dart';
import 'package:pomangam_client_flutter/_bases/util/log_utils.dart';
import 'package:pomangam_client_flutter/repositories/advertisement/advertisement_repository.dart';
import 'package:pomangam_client_flutter/repositories/coupon/coupon_repository.dart';
import 'package:pomangam_client_flutter/repositories/delivery/delivery_site_repository.dart';
import 'package:pomangam_client_flutter/repositories/delivery/detail/delivery_detail_site_repository.dart';
import 'package:pomangam_client_flutter/repositories/event/event_repository.dart';
import 'package:pomangam_client_flutter/repositories/faq/faq_repository.dart';
import 'package:pomangam_client_flutter/repositories/notice/notice_repository.dart';
import 'package:pomangam_client_flutter/repositories/order/order_repository.dart';
import 'package:pomangam_client_flutter/repositories/order/time/order_time_repository.dart';
import 'package:pomangam_client_flutter/repositories/point/point_repository.dart';
import 'package:pomangam_client_flutter/repositories/policy/policy_repository.dart';
import 'package:pomangam_client_flutter/repositories/product/product_repository.dart';
import 'package:pomangam_client_flutter/repositories/product/sub/product_sub_repository.dart';
import 'package:pomangam_client_flutter/repositories/promotion/promotion_repository.dart';
import 'package:pomangam_client_flutter/repositories/sign/sign_repository.dart';
import 'package:pomangam_client_flutter/repositories/store/review/store_review_repository.dart';
import 'package:pomangam_client_flutter/repositories/store/store_repository.dart';
import 'package:pomangam_client_flutter/repositories/version/version_repository.dart';

class InjectorRegister {

  static register() {
    try {
      Injector.appInstance

      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerSingleton<OauthTokenRepository>
          ((_) => OauthTokenRepository())


      /// A singleton ResourceRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerSingleton<ResourceRepository>
          ((injector) => ResourceRepository(
            oauthTokenRepository: injector.getDependency<OauthTokenRepository>()
        ))


      /// A dependency NetworkService provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<Api>
          ((injector) => Api(
            oauthTokenRepository: injector.getDependency<OauthTokenRepository>(),
            resourceRepository: injector.getDependency<ResourceRepository>()
        ))


      /// A dependency StoreRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<StoreRepository>
          ((injector) => StoreRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency SignRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<SignRepository>
          ((injector) => SignRepository(
            api: injector.getDependency<Api>(),
            initializer: injector.getDependency<Initializer>()
        ))


      /// A dependency Initializer provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<Initializer>
          ((injector) => Initializer(
            api: injector.getDependency<Api>()
        ))


      /// A dependency DeliveryDetailSiteRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<DeliveryDetailSiteRepository>
          ((injector) => DeliveryDetailSiteRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency DeliverySiteRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<DeliverySiteRepository>
          ((injector) => DeliverySiteRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency OrderRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<OrderRepository>
          ((injector) => OrderRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency OrderTimeRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<OrderTimeRepository>
          ((injector) => OrderTimeRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency ProductRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<ProductRepository>
          ((injector) => ProductRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency ProductSubRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<ProductSubRepository>
          ((injector) => ProductSubRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency AdvertisementRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<AdvertisementRepository>
          ((injector) => AdvertisementRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency PolicyRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<PolicyRepository>
          ((injector) => PolicyRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency PointRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<PointRepository>
          ((injector) => PointRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency CouponRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<CouponRepository>
          ((injector) => CouponRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency NoticeRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<NoticeRepository>
          ((injector) => NoticeRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency EventRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<EventRepository>
          ((injector) => EventRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency FaqRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<FaqRepository>
          ((injector) => FaqRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency StoreReviewRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<StoreReviewRepository>
          ((injector) => StoreReviewRepository(
            api: injector.getDependency<Api>()
        ))

      /// A dependency PromotionRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<PromotionRepository>
          ((injector) => PromotionRepository(
            api: injector.getDependency<Api>()
        ))


      /// A dependency VersionRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
        ..registerDependency<VersionRepository>
          ((injector) => VersionRepository(
            api: injector.getDependency<Api>()
        ));



      logWithDots('register', 'InjectorRegister.register', 'success');
    } catch (error) {
      logWithDots('register', 'InjectorRegister.register', 'failed', error: error);
    }
  }
}