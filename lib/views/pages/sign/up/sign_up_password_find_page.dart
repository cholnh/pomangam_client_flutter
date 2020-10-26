import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/basic_app_bar.dart';

class SignUpPasswordFindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: '보안코드 찾기',
        leadingIcon: Icon(CupertinoIcons.back, size: 20, color: Colors.black)
      ),
      body: SafeArea(),
    );
  }
}
