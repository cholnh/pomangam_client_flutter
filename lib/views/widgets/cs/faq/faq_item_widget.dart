import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';
import 'package:pomangam_client_flutter/views/widgets/_bases/custom_divider.dart';

class FaqItemWidget extends StatefulWidget {

  final String title;
  final String contents;
  final bool isLast;

  FaqItemWidget({this.title, this.contents, this.isLast = false});

  @override
  _FaqItemWidgetState createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: _onTap,
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Text('Q. ${widget.title}',
                        style: TextStyle(fontSize: 15.0, color: Theme.of(context).textTheme.headline1.color),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                    Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.black, size: 20)
                  ],
                ),
              ),
              if(isOpen) Html(
                data: 'A.<br>' + widget.contents,
                backgroundColor: Colors.grey[50],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                defaultTextStyle: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              if(widget.isLast) CustomDivider()
              else Divider(height: kIsWeb ? 1.0 : 0.5, thickness: 0.5)
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      this.isOpen = !isOpen;
    });
  }
}
