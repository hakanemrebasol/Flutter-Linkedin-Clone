import 'package:taskproject/models/publication/publication.dart';

class PublicationResponse {
  List<Publication> _publicationList;

  PublicationResponse({List<Publication> publicationList}) {
    this._publicationList = publicationList;
  }

  List<Publication> get publicationList => _publicationList;
  set publicationList(List<Publication> publicationList) => _publicationList = publicationList;

  PublicationResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Publication.fromJson(m)).toList();
    _publicationList = data;
  }
}
