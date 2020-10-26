import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicAppBar extends AppBar {
  BasicAppBar({
    bool centerTitle = true,
    bool automaticallyImplyLeading = true,
    bool isLeading = true,
    Icon leadingIcon,
    String title = '',
    Function onLeadingTap,
    double elevation = 0.0,
    List<Widget> actions
  }) : super (
    centerTitle: centerTitle,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: isLeading ? IconButton(
      icon: leadingIcon == null ? Icon(Icons.close, color: Theme.of(Get.context).textTheme.headline1.color, size: 20) : leadingIcon,
      onPressed: onLeadingTap == null ? () => Get.back() : () {},
    ) : null,
    title: Text('$title', style: TextStyle(
        color: Theme.of(Get.context).textTheme.headline1.color,
        fontSize: 16.0,
        fontWeight: FontWeight.normal
    )),
    actions: actions,
    elevation: elevation,
  );
}
