import 'package:flutter/material.dart';

class ProductSubItemTileWidget extends StatelessWidget {

  final bool isActive;
  final bool selected;
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  final Function onTap;
  final Function onInActiveTap;

  ProductSubItemTileWidget({this.isActive = true, this.selected = false, this.leading, this.subtitle, this.title, this.trailing, this.onTap, this.onInActiveTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : onInActiveTap,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.5,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: selected ? Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.0
                  ) : null
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: leading
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            //width: MediaQuery.of(context).size.width - 90 - 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$title', style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                )),
                                if(subtitle != null) SizedBox(height: 3),
                                if(subtitle != null) Text('$subtitle', style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black
                                ), maxLines: 2, overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                          isActive ? trailing : Text('품절', style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 13
                          ))
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
              Divider(height: 1.0, thickness: 0.5, color: Colors.grey[300])
            ],
          ),
        ),
      ),
    );
  }
}
