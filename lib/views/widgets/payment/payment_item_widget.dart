import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';


class PaymentItemWidget extends StatelessWidget {

  final String title;
  final String subTitle;
  final Widget trailing;
  final Function onSelected;
  final bool isActive;
  final bool isLast;

  PaymentItemWidget({
    this.title, this.subTitle, this.onSelected, this.isActive = true,
    this.trailing = const Icon(Icons.chevron_right, color: Colors.black, size: 20),
    this.isLast = false
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => isActive ? onSelected == null ? {} : onSelected() : {},
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Opacity(
                  opacity: isActive ? 1.0 : 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('$title', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Theme.of(context).textTheme.headline1.color)),
                          Padding(padding: const EdgeInsets.only(bottom: 4.0)),
                          subTitle != null ? Text('$subTitle', style: TextStyle(fontSize: 13.0, color: Colors.black.withOpacity(0.5))) : Container()
                        ],
                      ),
                      trailing
                    ],
                  ),
                ),
              ),
              if(isLast) CustomDivider()
              else Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)
            ],
          ),
        ),
      ),
    );
  }
}
