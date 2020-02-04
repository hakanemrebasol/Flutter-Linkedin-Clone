import 'package:flutter/material.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/util/status_codes.dart';
import 'package:taskproject/widgets/buttons/main_button.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/progress_widget.dart';
import 'package:taskproject/widgets/toasts/toasts.dart';

class EditAboutScreen extends StatefulWidget {
  final String aboutText;

  const EditAboutScreen({Key key, this.aboutText}) : super(key: key);
  @override
  _EditAboutScreenState createState() => _EditAboutScreenState();
}

class _EditAboutScreenState extends State<EditAboutScreen> {
  HttpService _httpService = HttpClient.getInstance();
  var _aboutController = new TextEditingController();
  bool _isUpdating = false;

  @override
  void initState() {
    print(widget.aboutText);
    setState(() {
      _aboutController.text = widget.aboutText;
    });
    super.initState();
  }

  updateUserAbout() async {
    if (_aboutController.text.isEmpty) {
      Toasts.showWarningToast('Please fill about field.');
      return;
    }

    setState(() {
      _isUpdating = true;
    });

    var response = await _httpService.updateUserAbout(_aboutController.text);

    if (response.statusCode == StatusCodes.ok) {
      Toasts.showSuccessToasts('Success.');
      sendBroadcastMessage(refreshProfileSummary);
      Navigator.of(context).pop();
    } else {
      Toasts.showErrorToast('Unable to update.');
    }

    setState(() {
      _isUpdating = false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit About'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: Column(
          children: <Widget>[
            AppForm(
              label: 'About',
              controller: _aboutController,
              obscureText: false,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _isUpdating
                    ? ProgressWidget()
                    : MainButton(
                        title: 'Save',
                        onPressButton: () {
                          updateUserAbout();
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
