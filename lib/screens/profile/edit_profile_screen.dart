import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskproject/helper/image_extensions.dart';
import 'package:taskproject/models/country/district.dart';
import 'package:taskproject/models/country/district_response.dart';
import 'package:taskproject/models/country/province.dart';
import 'package:taskproject/models/country/province_response.dart';
import 'package:taskproject/models/industry/industry.dart';
import 'package:taskproject/models/industry/industry_response.dart';
import 'package:taskproject/models/profile/profile.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/date_extension.dart';
import 'package:taskproject/util/status_codes.dart';
import 'package:taskproject/widgets/buttons/main_button.dart';
import 'package:taskproject/widgets/date/date_holder.dart';
import 'package:taskproject/widgets/forms/app_form.dart';
import 'package:taskproject/widgets/images/cached_images.dart';
import 'package:taskproject/widgets/progress_widget.dart';
import 'package:taskproject/widgets/toasts/toasts.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var _nameController = new TextEditingController();
  var _surnameControler = new TextEditingController();
  var _websiteController = new TextEditingController();
  var _headlineController = new TextEditingController();
  var _aboutController = new TextEditingController();
  var _addressController = new TextEditingController();
  var _zipController = new TextEditingController();
  Profile _profileModel;
  HttpService _httpService = HttpClient.getInstance();
  bool _isImageUploading = false;
  bool _isUpdating = false;
  List<Province> _provinceList = new List();
  List<District> _districtList = new List();
  List<Industry> _industryList = new List();
  Province _selectedProvince;
  District _selectedDistrict;
  Industry _selectedIndustry;
  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  getProfileDetails() async {
    Response response = await _httpService.getProfile();
    setState(() {
      _profileModel = Profile.fromJson(response.data);
      _selectedProvince = _profileModel.province;
      getProvinceList();
      setControllers();
      getIndustryList();
    });
  }

  getProvinceList() async {
    Response response = await _httpService.getProvinceList();
    setState(() {
      _selectedProvince = _profileModel.province;
      _provinceList =
          ProvinceResponse.fromJsonArray(response.data).provinceList;
      //Searching user's province.
      _selectedProvince = _provinceList.firstWhere(
          (province) => province.provinceId == _selectedProvince.provinceId,
          orElse: () => null);
      getDistrictList(_selectedProvince.provinceId);
    });
  }

  getDistrictList(int provinceId) async {
    setState(() {
      _selectedDistrict = null;
      _districtList.clear();
    });

    Response response = await _httpService.getDistrictList(provinceId);
    setState(() {
      _selectedDistrict = _profileModel.district;
      _districtList =
          DistrictResponse.fromJsonArray(response.data).districtList;
      //Searching user's district.
      _selectedDistrict = _districtList.firstWhere(
          (district) => district.districtId == _selectedDistrict.districtId,
          orElse: () => null);
    });
  }

  getIndustryList() async {
    _selectedIndustry = _profileModel.industry;
    Response response = await _httpService.getIndustryList();
    setState(() {
      _industryList =
          IndustryResponse.fromJsonArray(response.data).industryList;
      //Searching user's industry.
      _selectedIndustry = _industryList.firstWhere(
          (industry) => industry.industryId == _selectedIndustry.industryId,
          orElse: () => null);
    });
  }

  updateProfile() async {
    setState(() {
      _isUpdating = true;
    });

    _profileModel.about = _aboutController.text;
    _profileModel.address = _addressController.text;
    _profileModel.district = _selectedDistrict;
    _profileModel.province = _selectedProvince;
    _profileModel.industry = _selectedIndustry;
    _profileModel.name = _nameController.text;
    _profileModel.surname = _surnameControler.text;
    _profileModel.website = _websiteController.text;
    _profileModel.headline = _headlineController.text;
    _profileModel.zipCode = _zipController.text;
    _profileModel.birthDate = _profileModel.birthDate;

    Response response = await _httpService.updateProfile(_profileModel);
    if (response.statusCode == HttpStatus.ok) {
      _refreshProfileSummary();
      Toasts.showSuccessToasts("Succesfully updated");
      Navigator.of(context).pop();
    } else {
      Toasts.showSuccessToasts("Unable to update.");
    }
    setState(() {
      _isUpdating = false;
    });
  }

  _refreshProfileSummary() {
    sendBroadcastMessage(refreshProfileSummary);
  }

  setControllers() {
    _nameController.text = _profileModel.name;
    _surnameControler.text = _profileModel.surname;
    _websiteController.text = _profileModel.website;
    _headlineController.text = _profileModel.headline;
    _aboutController.text = _profileModel.about;
    _addressController.text = _profileModel.address;
    _zipController.text = _profileModel.zipCode;
  }

  takePictureFromGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    File croppedImage;
    if (image == null) {
      Toasts.showWarningToast('Please pick picture.');
    } else {
      croppedImage = await ImageExtensions.cropImage(image);
      if (croppedImage == null) {
        Toasts.showWarningToast('Please crop your image.');
        return;
      }
      await uploadProfilePicture(croppedImage);
    }
  }

  uploadProfilePicture(File croppedImage) async {
    setState(() {
      _isImageUploading = true;
    });
    Response response = await _httpService.uploadPP(croppedImage);
    if (response.statusCode == StatusCodes.ok) {
      Toasts.showSuccessToasts('Succesfully uploaded.');
      CachedImages.clearCache();
      _refreshProfileSummary();
      Navigator.of(context).pop();
    } else {
      Toasts.showErrorToast('Unable to upload.');
    }
    setState(() {
      _isImageUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Profile'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: _profileModel == null ? ProgressWidget() : body(),
        )),
      ),
    );
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InkWell(
          onTap: () {
            takePictureFromGallery();
          },
          child: _isImageUploading
              ? ProgressWidget()
              : Hero(
                  tag: "pp",
                  child: CachedImages.getPPNetworkImage(_profileModel.id, 120)),
        ),
        AppForm(
          label: 'Name',
          controller: _nameController,
          obscureText: false,
        ),
        AppForm(
          label: 'Surname',
          controller: _surnameControler,
          obscureText: false,
        ),
        AppForm(
          label: 'Headline',
          controller: _headlineController,
          obscureText: false,
        ),
        AppForm(
          label: 'About',
          controller: _aboutController,
          obscureText: false,
        ),
        DateHolder(
          hint: 'Birth Date',
          initialDate: _profileModel.birthDate,
          onDateSelect: (value) {
            setState(() {
              _profileModel.birthDate = value;
            });
          },
          dateFormat: ddMMyyyyFormat,
        ),
        AppForm(
          label: 'Website',
          controller: _websiteController,
          obscureText: false,
        ),
        _provinceList.length == 0 ? ProgressWidget() : provinceDropDown(),
        _districtList.length == 0 ? ProgressWidget() : districtDropdown(),
        AppForm(
          label: 'Address',
          controller: _addressController,
          obscureText: false,
        ),
        AppForm(
          label: 'ZIP Code',
          controller: _zipController,
          obscureText: false,
        ),
        _industryList.length == 0 ? ProgressWidget() : industryDropDown(),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _isUpdating
                ? ProgressWidget()
                : MainButton(
                    title: 'Save',
                    onPressButton: () {
                      updateProfile();
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget provinceDropDown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Province',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .merge(TextStyle(color: CustomColors.colorPrimary)),
            ),
            DropdownButton<Province>(
                items: _provinceList.map((Province val) {
                  return new DropdownMenuItem<Province>(
                    value: val,
                    child: new Text(val.provinceName),
                  );
                }).toList(),
                hint: Text("Please choose a location"),
                value: _selectedProvince,
                onChanged: (newVal) {
                  this.setState(() {
                    _selectedProvince = newVal;
                    _profileModel.province = newVal;
                    getDistrictList(_selectedProvince.provinceId);
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget districtDropdown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'District',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .merge(TextStyle(color: CustomColors.colorPrimary)),
            ),
            DropdownButton<District>(
                items: _districtList.map((District val) {
                  return new DropdownMenuItem<District>(
                    value: val,
                    child: new Text(val.districtName),
                  );
                }).toList(),
                hint: Text("Please choose a location"),
                value: _selectedDistrict,
                onChanged: (newVal) {
                  this.setState(() {
                    _selectedDistrict = newVal;
                    _profileModel.district = newVal;
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget industryDropDown() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Industry',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .merge(TextStyle(color: CustomColors.colorPrimary)),
            ),
            DropdownButton<Industry>(
                items: _industryList.map((Industry val) {
                  return new DropdownMenuItem<Industry>(
                    value: val,
                    child: new Text(val.industryName),
                  );
                }).toList(),
                hint: Text("Please choose a industry"),
                value: _selectedIndustry,
                onChanged: (newVal) {
                  this.setState(() {
                    _selectedIndustry = newVal;
                    _profileModel.industry = newVal;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
