import 'package:flutter/material.dart';
import 'package:taskproject/models/publication/publication.dart';
import 'package:taskproject/router.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/date_extension.dart';

class SectionAccomplishments extends StatefulWidget {
  final List<Publication> publicationList;

  const SectionAccomplishments({Key key, this.publicationList})
      : super(key: key);

  @override
  _SectionAccomplishmentsState createState() => _SectionAccomplishmentsState();
}

class _SectionAccomplishmentsState extends State<SectionAccomplishments> {
  @override
  Widget build(BuildContext context) {
    return publicationSummaryWidget();
  }

  Widget publicationSummaryWidget() {
    var summaryText = "";
    for (var item in widget.publicationList)
      summaryText += item.description + " • ";

    return ExpansionTile(
      leading: Text(
        widget.publicationList.length.toString(),
        style: TextStyle(color: CustomColors.colorPrimary, fontSize: 24),
      ),
      title: Text(
        'Publications',
        style: TextStyle(color: CustomColors.colorPrimary),
      ),
      subtitle: Text(summaryText),
      children: <Widget>[publicationListWidget()],
      initiallyExpanded: false,
    );
  }

  Widget publicationListWidget() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: widget.publicationList.length,
      itemBuilder: (context, pos) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, addPublicationRoute,
                arguments: widget.publicationList[pos]);
          },
          child: ListTile(
            isThreeLine: true,
            leading: Icon(
              Icons.public,
              color: CustomColors.colorPrimary,
            ),
            title: Text(widget.publicationList[pos].description),
            subtitle: Text(widget.publicationList[pos].publisherName +
                " • " +
                convertDateToFormat(widget.publicationList[pos].publishDate,ddMMyyyyFormat) +
                "\n" +
                widget.publicationList[pos].url),
          ),
        );
      },
    );
  }
}
