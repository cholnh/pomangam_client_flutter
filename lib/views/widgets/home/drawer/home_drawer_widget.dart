import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomangam_client_flutter/views/widgets/home/drawer/home_drawer_body_widget.dart';
import 'package:pomangam_client_flutter/views/widgets/home/drawer/home_drawer_header_widget.dart';
import 'package:provider/provider.dart';

import 'package:pomangam_client_flutter/providers/sign/sign_in_model.dart';
import 'package:pomangam_client_flutter/views/pages/sign/in/sign_in_page.dart';
import 'package:pomangam_client_flutter/views/pages/user_info/user_info_page.dart';

class HomeDrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSignIn = Provider.of<SignInModel>(context, listen: false).isSignIn();

    return Drawer(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0x30, 0x30, 0x30, 1.0),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 20.0)),
              HomeDrawerHeaderWidget(
                width: size.width * 0.7,
                onTap: isSignIn
                    ? () => Get.to(UserInfoPage(), duration: Duration.zero)
                    : () => Get.to(SignInPage(), duration: Duration.zero),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 15.0)),
              Divider(thickness: 8.0, color: Colors.black.withOpacity(0.1)),
              HomeDrawerBodyWidget(
                height: size.height * 0.5,
              )
            ],
          ),
        ),
      )
    );
  }
}
