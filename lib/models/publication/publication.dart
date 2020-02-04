import 'package:taskproject/util/date_extension.dart';

class Publication {
  int _publicationId;
  String _publisherName;
  DateTime _publishDate;
  String _url;
  String _description;

  Publication(
      {int publicationId,
      String publisherName,
      DateTime publishDate,
      String url,
      String description}) {
    this._publicationId = publicationId;
    this._publisherName = publisherName;
    this._publishDate = publishDate;
    this._url = url;
    this._description = description;
  }

  int get publicationId => _publicationId;
  set publicationId(int publicationId) => _publicationId = publicationId;
  String get publisherName => _publisherName;
  set publisherName(String publisherName) => _publisherName = publisherName;
  DateTime get publishDate => _publishDate;
  set publishDate(DateTime publishDate) => _publishDate = publishDate;
  String get url => _url;
  set url(String url) => _url = url;
  String get description => _description;
  set description(String description) => _description = description;

  Publication.fromJson(Map<String, dynamic> json) {
    _publicationId = json['publicationId'];
    _publisherName = json['publisherName'];
    _publishDate = convertStrToDatetime(json['publishDate']);
    _url = json['url'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._publicationId != null) {
      data['publicationId'] = this._publicationId;
    }
    data['publisherName'] = this._publisherName;
    data['publishDate'] = this._publishDate.toIso8601String();
    data['url'] = this._url;
    data['description'] = this._description;
    return data;
  }
}
