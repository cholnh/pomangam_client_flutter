```
███╗   ███╗██████╗    ██████╗  ██████╗ ██████╗ ████████╗███████╗██████╗
████╗ ████║██╔══██╗   ██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
██╔████╔██║██████╔╝   ██████╔╝██║   ██║██████╔╝   ██║   █████╗  ██████╔╝
██║╚██╔╝██║██╔══██╗   ██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══╝  ██╔══██╗
██║ ╚═╝ ██║██║  ██║██╗██║     ╚██████╔╝██║  ██║   ██║   ███████╗██║  ██║
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
```
---

## 예약배송 플랫폼 포만감v1.2, 고객용 Flutter 앱

### 수행기간
- 2018-11 ~ 2020-11

### 사용기술
- Dart, Flutter

### 인원
- 1명 ([NTEVE](https://github.com/cholnh))

### 개요
- 받는 장소와 시간을 선택한 뒤 업체들의 제품을 골라 결제하면 주문예약이 되는 하이브리드 어플리케이션.

### 스크린샷
|시연영상|업체화면|제품화면|장바구니|주문목록|
|--|--|--|--|--|
|[![s1_1](https://user-images.githubusercontent.com/23611497/110624857-1895e200-81e2-11eb-976f-473fdb0f9dbc.png)](https://user-images.githubusercontent.com/23611497/110623244-ed11f800-81df-11eb-96cb-ed391994d3ed.mp4)|![s2](https://user-images.githubusercontent.com/23611497/110620268-2a748680-81dc-11eb-922d-9a50c5af3f9b.png)|![s3](https://user-images.githubusercontent.com/23611497/110620533-745d6c80-81dc-11eb-89c7-129257107548.png)|![cart_1](https://user-images.githubusercontent.com/23611497/110620760-c3a39d00-81dc-11eb-8af8-6b1378062ffc.png)|![s4](https://user-images.githubusercontent.com/23611497/110620784-c900e780-81dc-11eb-87a4-1f9d4c98218c.png)|


### 주요특징
|키워드|설명|링크|
|--|--|--|
| Provider 패턴 | Ui와 비즈니스 로직을 분리 및 데이터 공유. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/tree/master/lib/providers)|
| Localization | i18n을 제공하기 위해  intl 사용. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/master/lib/_bases/i18n/messages.dart)|
| OAuth2.0 | OAuth Token 발급, 관리 및 Resource Server와 연결하는 모듈 구현. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/_bases/network/repository/authorization_repository.dart#L8-L185)|
| FCM | 푸시 알림 모듈 구현. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/_bases/initalizer/initializer.dart#L226-L278)|
| PG 연동| 부트페이 API 사용하여 PG 연동. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/providers/payment/pg_model.dart#L18-L49)|
| Json | json_serializable 패키지를 통해 JsonSerializableGenerator 생성하어 서버로 부터 받아온 Json 값을 내부 domain으로 변환. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/domains/deliverysite/delivery_site.dart#L21-L27)|
| Widgets | XD, Zeplin으로 전달 받은 디자인 결과물을 바탕으로 Widgets 구현. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/tree/master/lib/views)|
| Infinite Scroll Pagination | 서버 비동기 통신을 통해 Pageable 리스트를 받아와 화면에 끊임없이 Loading 되는 widget 구현. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/providers/store/store_summary_model.dart#L40-L49)|
| Firebase Crashlytics | 비정상 종료 모니터링. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/main.dart#L26-L34)|
| Kakao API | 카카오 로그인 API 연결하여 간편 로그인 구현. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/views/widgets/sign/in/sign_in_phone_number_input_widget.dart#L145-L160)|
| GoogleMap API | 구글 지도 API 사용. |[:arrow_right:](https://github.com/cholnh/pomangam_client_flutter/blob/cc89fcd49f75bc4e6cb5783cae8f2653918c017a/lib/views/widgets/deliverysite/detail/delivery_detail_site_web_map_widget.dart#L33-L48)|

### 결과
- ‘포만감’ 안드로이드 어플리케이션 배포 ( https://play.google.com/store/apps/details?id=com.mrporter.flutter.client.pomangam )
- 2018 고양지식정보산업진흥원 고-로켓 창업 아이디어 공모전 수상, 경진대회 2위 수상
- 2018 경기도경제과학진흥원 경기북부 대학생 창업경진대회 은상 수상
- 2018 광운대 도시樂 창업경진대회 1위 수상
- 2018 미래로 고양 창업경진대회 2위 수상
- 2019 특허 출원 경험 (다중 주문 실시간 배송 처리 장치 및 이를 이용한 다중 주문 실시간 배송 처리 방법, 10-2019-0022262)
- 2019 중국 국영 중강그룹 글로벌창업경진대회 2등 단체상 수상
- 2019 공학 페스티벌 창업투자 아이디어 경진대회 1위 수상

### 문서
- v1.0 API 문서 ( https://pomangam.docs.apiary.io )
- 주문 프로세스 문서 ( https://docs.google.com/document/d/1NTP_Ha8Gyu34hkUNxTii0bGyOfa5j-gOX-HamKXpCFw/edit )
