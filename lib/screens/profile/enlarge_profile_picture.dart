import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/widgets/progress_widget.dart';

class EnlargeProfilePicture extends StatelessWidget {
  final String userId;

  const EnlargeProfilePicture({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
                  child: Hero(
            tag: 'pp',
            child: CachedNetworkImage(
              imageUrl: HttpService.getPPpath(userId),
              fit: BoxFit.cover,
              placeholder: (context, url) => new ProgressWidget(),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/ic_defaultpp.png',
              ),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
        ));
  }
}
