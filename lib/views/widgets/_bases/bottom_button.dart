import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {

  final double height;
  final Color backgroundColor;
  final Color textColor;
  final bool isActive;
  final String text;
  final FontWeight fontWeight;
  final Function onTap;

  BottomButton({
    this.height = 65.0,
    this.backgroundColor,
    this.textColor,
    this.isActive = true,
    this.text = '',
    this.fontWeight = FontWeight.bold,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            isActive ? Container() : CupertinoActivityIndicator(),
            Opacity(
              opacity: isActive ? 1.0 : 0.5,
              child: SizedBox(
                height: height,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: backgroundColor == null
                      ? Theme.of(context).primaryColor
                      : backgroundColor,
                    child: Center(
                      child: isActive
                        ? Text(text, style: TextStyle(
                          fontWeight: fontWeight,
                          color: textColor == null
                            ? Theme.of(context).backgroundColor
                            : textColor,
                          fontSize: 16.0
                      ))
                        : Container(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: isActive ? onTap : (){},
      ),
    );
  }
}
