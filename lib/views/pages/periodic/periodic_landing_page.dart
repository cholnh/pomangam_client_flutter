import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/views/pages/periodic/periodic_carte_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/bottom_button.dart';
import 'package:pomangam_client_flutter/views/widgets/periodic/periodic_landing_image_widget.dart';

class PeriodicLandingPage extends StatefulWidget {
  @override
  _PeriodicLandingPageState createState() => _PeriodicLandingPageState();
}

class _PeriodicLandingPageState extends State<PeriodicLandingPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        // appBar: BasicAppBar(
        //   title: '포만감 정기배달',
        //   isLeading: false,
        //   elevation: 1.0
        // ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PeriodicLandingImageWidget(),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image(
                                image: const AssetImage('assets/periodic_landing_1.jpg'),
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(width: 10),
                              Text('매번 번거로운 식사고민 No!', style: TextStyle(
                                color: Colors.black,
                                fontSize: 18
                              )),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Image(
                                image: const AssetImage('assets/periodic_landing_choices.png'),
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(width: 20),
                              Text('간편한 프리미엄 식단선택', style: TextStyle(
                                color: Colors.black,
                                fontSize: 18
                              )),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Image(
                                image: const AssetImage('assets/periodic_landing_shipped.png'),
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(width: 20),
                              Text('매일 정해진 시간과 장소로 배달됩니다. ', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              BottomButton(
                text: '시작하기',
                onTap: () => Get.to(PeriodicCartePage()),
              )
            ],
          ),
        ),
      ),
    );
  }


}
