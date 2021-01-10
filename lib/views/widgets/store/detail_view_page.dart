import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pomangam_client_flutter/_bases/constants/endpoint.dart';

class DetailViewPage extends StatefulWidget {

  final int initialIndex;
  final List imagePaths;

  DetailViewPage({this.initialIndex, this.imagePaths});

  @override
  _DetailViewPageState createState() => _DetailViewPageState();
}

class _DetailViewPageState extends State<DetailViewPage> {

  int currentIndex;
  ScrollController _scrollController = ScrollController();
  PageController pageController;
  List _keys = [];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: currentIndex);
    pageController.addListener(() {
      if(currentIndex != pageController.page.round()) {
        _select(pageController.page.round());
      }
    });

    for (int index = 0; index < widget.imagePaths.length; index++) {
      _keys.add(GlobalKey());
    }
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _scrollTo(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Icon(
                CupertinoIcons.back,
                color: Colors.black,
                size: 20.0
              )
            ),
          ),
        ),
        centerTitle: true,
        title: Text('상세이미지',
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1.color,
            fontSize: 18.0,
          )
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        toolbarHeight: 60.0,
      ),
      body: GestureDetector(
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              Expanded(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildItem,
                  itemCount: widget.imagePaths.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                      ),
                    ),
                  ),
                  backgroundDecoration: BoxDecoration(color: Theme.of(context).backgroundColor),
                  pageController: pageController,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  height: 50.0,
                  child: ListView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: _buildImagePreView(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _select(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
      _scrollTo(index);
    }
  }

  void _scrollTo(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    double size = renderBox.size.width;
    double position = renderBox.localToGlobal(Offset.zero).dx;
    double offset = (position + size / 2) - screenWidth / 2;

    if (offset < 0) {
      renderBox = _keys[0].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      if (position > offset) offset = position;
    } else {
      renderBox = _keys[widget.imagePaths.length - 1].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      size = renderBox.size.width;
      if (position + size < screenWidth) screenWidth = position + size;
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }
    _scrollController.animateTo(offset + _scrollController.offset - (index==0?0:0),
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    String imagePath = '${Endpoint.serverDomain}/${widget.imagePaths[index]}';
    return PhotoViewGalleryPageOptions(
      basePosition: Alignment.topCenter,
      imageProvider: CachedNetworkImageProvider(imagePath),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: imagePath),
    );
  }

  List<Widget> _buildImagePreView() {
    List<Widget> widgets = List();

    for(int i=0; i<widget.imagePaths.length; i++) {
      widgets.add(GestureDetector(
        onTap: () {
          pageController.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        },
        child: Container(
          key: _keys[i],
          height: 50.0,
          width: 50.0,
          margin: EdgeInsets.only(left: i==0 ? 15.0 : 2.5, right: i==widget.imagePaths.length-1 ? 15.0 : 2.5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: currentIndex == i
                ? Theme.of(Get.context).primaryColor
                : Theme.of(Get.context).dividerColor
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: '${Endpoint.serverDomain}/${widget.imagePaths[i]}',
            height: 50.0,
            width: 50.0,
            fit: BoxFit.fill,
          ),
        ),
      ));
    }
    return widgets;
  }
}