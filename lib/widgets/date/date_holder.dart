import 'package:flutter/material.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/date_extension.dart';
import 'package:taskproject/widgets/date/my_date_picker.dart';

class DateHolder extends StatefulWidget {
  final String hint;
  final ValueChanged<DateTime> onDateSelect;
  final List<String> dateFormat;
  final DateTime initialDate;

  const DateHolder(
      {Key key,
      this.hint,
      this.onDateSelect,
      this.dateFormat,
      this.initialDate})
      : super(key: key);

  @override
  _DateHolderState createState() => _DateHolderState();
}

class _DateHolderState extends State<DateHolder> {
  DateTime _selectedDate;
  @override
  void initState() {
    setInitialDate();
    super.initState();
  }

  setInitialDate() {
    if (widget.initialDate == null) {
      _selectedDate = DateTime.now();
    } else {
      _selectedDate = widget.initialDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.hint, style: Theme.of(context).textTheme.display2),
              InkWell(
                onTap: () {
                  pickDate();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                              _selectedDate == null
                                  ? 'Pick Date'
                                  : convertDateToFormat(
                                      _selectedDate, widget.dateFormat),
                              style: Theme.of(context).textTheme.title),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: CustomColors.colorPrimary,
                thickness: 1.1,
              )
            ]),
      ),
    );
  }

  pickDate() async {
    DateTime dateTime = await MyDatePicker.selectDate(context);
    setState(() {
      _selectedDate = dateTime;
    });
    widget.onDateSelect(dateTime);
  }
}
