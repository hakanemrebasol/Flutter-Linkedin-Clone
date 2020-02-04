import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/widgets/progress_widget.dart';

class CachedImages {
  static Widget getPPNetworkImage(String userId, double width) {
    return CachedNetworkImage(
      imageUrl: HttpService.getPPpath(userId),
      fit: BoxFit.cover,
      placeholder: (context, url) => new ProgressWidget(),
      errorWidget: (context, url, error) => CircleAvatar(
        backgroundImage: AssetImage('assets/images/ic_defaultpp.png'),
        radius: width / 2,
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  static Widget getCompanyIcon(String url, double width) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => new ProgressWidget(),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/ic_defaultpp.png',
        width: width,
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }

  static clearCache() {
    DefaultCacheManager().emptyCache();
  }
}
