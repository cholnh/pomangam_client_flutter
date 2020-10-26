import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pomangam_client_flutter/_bases/key/pmg_key.dart';
import 'package:pomangam_client_flutter/_bases/util/string_utils.dart';
import 'package:pomangam_client_flutter/providers/store/store_model.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDescriptionWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: PmgKeys.storeDescription,
      child: Container(
        padding: EdgeInsets.only(left: 15.0, bottom: 20.0, right: 15.0),
        alignment: Alignment.centerLeft,
        child: Consumer<StoreModel>(
          builder: (_, model, child) {
            bool isStoreDescriptionOpened = model.isStoreDescriptionOpened;
            bool isFetching = model.isStoreFetching;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if(isFetching) CustomShimmer(width: 70, height: 13)
                else Text('${model.store?.storeInfo?.name ?? ''}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)),
                const SizedBox(height: 3),
                if(isFetching) Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: CustomShimmer(width: 30, height: 13),
                )
                else Text('${model.store?.storeCategory ?? ''}', style: TextStyle(color: Colors.black45, fontSize: 12.0)),
                if(isFetching) CustomShimmer(width: 180, height: 13)
                else Text('${model.store?.storeInfo?.description ?? ''}',
                    maxLines: isStoreDescriptionOpened ? 20 : 5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.headline1.color)
                ),
                model.store?.storeInfo?.subDescription != null
                  ? Text('${model.store?.storeInfo?.subDescription ?? ''}',
                      maxLines: isStoreDescriptionOpened ? 20 : 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontSize: 12.0)
                    )
                  : Container(),
                isStoreDescriptionOpened && !isFetching
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),

                      // 영업정보
                      Text('영업 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)),
                      const SizedBox(height: 3),
                      GestureDetector(
                        onTap: model.store?.storeInfo?.companyPhoneNumber != null
                          ? () => _launch('${model.store?.storeInfo?.companyPhoneNumber}')
                          : () {},
                        child: Row(
                          children: <Widget>[
                            Text('전화번호 : ${model.store?.storeInfo?.companyPhoneNumber ?? '미등록'}', style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.headline1.color)),
                            const SizedBox(width: 10),
                            model.store?.storeInfo?.companyPhoneNumber != null
                                ? Text('전화하기', style: TextStyle(color: Theme.of(Get.context).primaryColor, fontSize: 11.0))
                                : Container()
                          ],
                        ),
                      ),
                      Text(
                          '운영시간 : ${_timeFormat(model.store?.storeSchedule?.openTime) ?? ''} ~ ${_timeFormat(model.store?.storeSchedule?.closeTime) ?? ''}',
                          style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.headline1.color)
                      ),
                      const SizedBox(height: 20),

                      // 사업자 정보
                      Text('사업자 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: Theme.of(context).textTheme.headline1.color)),
                      const SizedBox(height: 3),
                      Text('대표자명 : ${model.store?.storeInfo?.ownerName ?? '미등록'}', style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.headline1.color)),
                      Text('상호명 : ${model.store?.storeInfo?.companyName ?? '미등록'}', style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.headline1.color)),
                      Text('위치 : ${model.store?.storeInfo?.companyLocation ?? '미등록'}', style: TextStyle(fontSize: 12.0, color: Theme.of(context).textTheme.headline1.color)),
                    ],
                  )
                : Container()
              ],
            );
          }
        ),
      )
    );
  }

  String _timeFormat(String time) {
    if(time == null) return null;
    var times = time.split(':');
    return '${times[0]}:${times[1]}';
  }

  void _launch(String tel) async {
    tel = StringUtils.onlyNumber(tel);
    var url = 'tel://$tel';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}