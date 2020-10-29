import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefresher extends StatelessWidget {

  final RefreshController controller;
  final Widget child;
  final Function onRefresh;
  final Function onLoading;
  final bool enablePullDown;
  final bool enablePullUp;

  CustomRefresher({
    this.controller,
    this.child,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = true
  });

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerTriggerDistance: 50.0,
      child: SmartRefresher(
        physics: BouncingScrollPhysics(),
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        header: ClassicHeader(
          refreshStyle: RefreshStyle.UnFollow,
          height: 50,
          idleIcon: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Icon(Icons.refresh, color: Theme.of(context).iconTheme.color)
          ),
          idleText: '',
          refreshingIcon: _loadingWidget(isHeader: true),
          refreshingText: '',
          releaseIcon: _loadingWidget(isHeader: true),
          releaseText: '',
          completeDuration: Duration(milliseconds: 300),
          completeIcon: _loadingWidget(isHeader: true),
          completeText: '',
          failedText: '새로고침 오류',
        ),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          noDataText: '',
          canLoadingText: '',
          loadingText: '',
          loadingIcon: _loadingWidget(isHeader: false),
          completeDuration: Duration(milliseconds: 300),
          canLoadingIcon: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Icon(Icons.autorenew, color: Theme.of(context).iconTheme.color)
          ),
          idleText: '',
          idleIcon: null,
          failedText: '탭하여 다시 시도',
        ),
        controller: controller,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: child
      ),
    );
  }

  Widget _loadingWidget({bool isHeader}) => Padding(
      padding: EdgeInsets.only(top: isHeader ? 20 : 0, bottom: isHeader ? 20 : 20),
      child: CupertinoActivityIndicator());
}
