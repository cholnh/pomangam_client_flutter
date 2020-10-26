import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class DialogUtils {
  static void dialog(BuildContext context, String title, {
    double height = 130,
    Widget contents,
    Function(BuildContext) onPressed,
    Function whenComplete
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text('$title', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline1.color
                        )),
                        if(contents != null) SizedBox(height: 20),
                        if(contents != null) contents
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPressed != null
                  ? () async {
                    await onPressed(dialogContext);
                    if(Navigator.of(dialogContext).canPop()) {
                      Navigator.of(dialogContext).pop();
                    }
                  }
                  : () async {
                    if(Navigator.of(dialogContext).canPop()) {
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: 45,
                    child: Center(
                      child: Text('확인', style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ).whenComplete(() async {
      if(whenComplete != null) {
        await whenComplete();
      }
    });
  }

  static void dialogYesOrNo(BuildContext context, String title, {
    double height = 130,
    Widget contents,
    String confirm = '예',
    String cancel = '아니오',
    Function(BuildContext) onConfirm,
    Function(BuildContext) onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                    child: Column(
                      children: [
                        Text('$title', style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline1.color
                        )),
                        if(contents != null) SizedBox(height: 20),
                        if(contents != null) contents
                        // Text('$contents', style: TextStyle(
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.normal,
                        //     color: Theme.of(context).textTheme.headline1.color
                        // ), maxLines: 3, overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onConfirm != null
                        ? () async {
                          if(Navigator.of(dialogContext).canPop()) {
                            Navigator.of(dialogContext).pop();
                          }
                          await onConfirm(dialogContext);
                        }
                        : () async {
                          if(Navigator.of(dialogContext).canPop()) {
                            Navigator.of(dialogContext).pop();
                          }
                        },
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          height: 45,
                          child: Center(
                            child: Text('$confirm', style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                            )),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: onCancel != null
                        ? () async {
                          if(Navigator.of(dialogContext).canPop()) {
                            Navigator.of(dialogContext).pop();
                          }
                          await onCancel(dialogContext);
                        }
                        : () async {
                          if(Navigator.of(dialogContext).canPop()) {
                            Navigator.of(dialogContext).pop();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 0.5
                              )
                            )
                          ),
                          height: 45,
                          child: Center(
                            child: Text('$cancel', style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
