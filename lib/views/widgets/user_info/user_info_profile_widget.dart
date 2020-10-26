import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/providers/point/point_model.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_page.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_dialog_utils.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';
import 'package:pomangam_client_flutter/views/widgets/user_info/user_info_point_reward_widget.dart';
import 'package:provider/provider.dart';
import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';

class UserInfoProfileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<SignInModel>(
        builder: (_, userModel, __) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(332 / 360),
                        child: Image(
                            image: const AssetImage('assets/logo.png'),
                            width: 50,
                            height: 50
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 13.0)),
                      Expanded(
                        child: userModel.isSignIn()
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${userModel?.userInfo?.nickname ?? ''} 님',  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.headline1.color)),
                            Padding(padding: const EdgeInsets.only(bottom: 5.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Lv${userModel?.userInfo?.userPointRank?.level ?? 0} ${userModel?.userInfo?.userPointRank?.title ?? ''} 등급',  style: TextStyle(fontSize: 13.0)),
                                GestureDetector(
                                  onTap: _onTap,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                                      child: Text('등급별 혜택',  style: TextStyle(fontSize: 13.0, color: Theme.of(context).primaryColor)),
                                    )
                                  )
                                ),
                              ],
                            )
                          ],
                        )
                        : GestureDetector(
                          onTap: _login,
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('로그인',  style: TextStyle(
                                      color: Theme.of(context).textTheme.headline1.color,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold
                                    )),
                                    Text(' 해주세요',  style: TextStyle(
                                      color: Theme.of(context).textTheme.headline1.color,
                                      fontSize: 16.0,
                                    )),
                                  ],
                                ),
                                const Icon(Icons.chevron_right, color: Colors.black)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               CustomDivider()
              ],
            ),
          );
        },
      ),
    );
  }

  void _login() {
    Get.to(SignInPage(), duration: Duration.zero);
  }

  void _onTap() {
    Get.context.read<PointModel>().fetchRanks();
    showDialog(
      context: Get.context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Material(
          color: Theme.of(Get.context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20.0, bottom: 20),
            child: UserInfoPointRewardWidget()
          ),
        ),
      )
    );
  }
}
