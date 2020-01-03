import 'package:easy_app/base_file.dart';
import 'package:easy_app/page/image_scan/image_scan_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageScanPage extends BaseStatelessPage {
  ImageScanBloc _bloc;

  ImageScanPage() {
    _bloc = ImageScanBloc();
  }

  @override
  String initAppName() => "";

  @override
  bool showAppBar() => false;

  @override
  Widget initChild() {
    // TODO: implement initChild
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: StreamBuilder<List<String>>(
                stream: _bloc.imagesStream,
                initialData: _bloc.images,
                builder: (ctx, short) => GestureDetector(
                  child: PhotoViewGallery(
                      onPageChanged: (int index) {
                        _bloc.changeIndex(index + 1);
                      },
                      pageOptions: short.data
                          .map((string) => PhotoViewGalleryPageOptions(
                              imageProvider: NetworkImage(string)))
                          .toList()),
                  onTapUp: (info) {
                    Navigator.pop(basePageContext);
                  },
                ),
              )),
          Positioned(
            child: StreamBuilder<List<String>>(
              stream: _bloc.imagesStream,
              initialData: _bloc.images,
              builder: (ctx, short) => Container(
                child: StreamBuilder<int>(
                  initialData: _bloc.curIndex,
                  stream: _bloc.curIndexStream,
                  builder: (ctx, indexShort) => Text(
                    "${indexShort.data}/${short.data.length}",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
            top: MediaQuery.of(basePageContext).padding.top + 10,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }
}
