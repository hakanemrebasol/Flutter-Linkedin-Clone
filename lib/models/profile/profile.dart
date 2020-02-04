import 'package:taskproject/models/country/district.dart';
import 'package:taskproject/models/country/province.dart';
import 'package:taskproject/models/industry/industry.dart';
import 'package:taskproject/util/date_extension.dart';

class Profile {
  String _id;
  String _name;
  String _surname;
  String _userName;
  String _email;
  String _location;
  String _countryCode;
  String _phoneNumber;
  String _password;
  bool _emailConfirmed;
  bool _phoneNumberConfirmed;
  String _about;
  String _headline;
  String _website;
  DateTime _birthDate;
  String _address;
  String _zipCode;
  Province _province;
  District _district;
  Industry _industry;

  Profile(
      {String id,
      String name,
      String surname,
      String userName,
      String email,
      String location,
      String countryCode,
      String phoneNumber,
      String password,
      bool emailConfirmed,
      bool phoneNumberConfirmed,
      String about,
      String headline,
      String website,
      DateTime birthDate,
      String address,
      String zipCode,
      Province province,
      District district,
      Industry industry}) {
    this._id = id;
    this._name = name;
    this._surname = surname;
    this._userName = userName;
    this._email = email;
    this._location = location;
    this._countryCode = countryCode;
    this._phoneNumber = phoneNumber;
    this._password = password;
    this._emailConfirmed = emailConfirmed;
    this._phoneNumberConfirmed = phoneNumberConfirmed;
    this._about = about;
    this._headline = headline;
    this._website = website;
    this._birthDate = birthDate;
    this._address = address;
    this._zipCode = zipCode;
    this._province = province;
    this._district = district;
    this._industry = industry;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get surname => _surname;
  set surname(String surname) => _surname = surname;
  String get userName => _userName;
  set userName(String userName) => _userName = userName;
  String get email => _email;
  set email(String email) => _email = email;
  String get location => _location;
  set location(String location) => _location = location;
  String get countryCode => _countryCode;
  set countryCode(String countryCode) => _countryCode = countryCode;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  String get password => _password;
  set password(String password) => _password = password;
  bool get emailConfirmed => _emailConfirmed;
  set emailConfirmed(bool emailConfirmed) => _emailConfirmed = emailConfirmed;
  bool get phoneNumberConfirmed => _phoneNumberConfirmed;
  set phoneNumberConfirmed(bool phoneNumberConfirmed) =>
      _phoneNumberConfirmed = phoneNumberConfirmed;
  String get about => _about;
  set about(String about) => _about = about;
  String get headline => _headline;
  set headline(String headline) => _headline = headline;
  String get website => _website;
  set website(String website) => _website = website;
  DateTime get birthDate => _birthDate;
  set birthDate(DateTime birthDate) => _birthDate = birthDate;
  String get address => _address;
  set address(String address) => _address = address;
  String get zipCode => _zipCode;
  set zipCode(String zipCode) => _zipCode = zipCode;
  Province get province => _province;
  set province(Province province) => _province = province;
  District get district => _district;
  set district(District district) => _district = district;
  Industry get industry => _industry;
  set industry(Industry industry) => _industry = industry;

  Profile.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _surname = json['surname'];
    _userName = json['userName'];
    _email = json['email'];
    _location = json['location'];
    _countryCode = json['countryCode'];
    _phoneNumber = json['phoneNumber'];
    _password = json['password'];
    _emailConfirmed = json['emailConfirmed'];
    _phoneNumberConfirmed = json['phoneNumberConfirmed'];
    _about = json['about'];
    _headline = json['headline'];
    _website = json['website'];
    _birthDate = convertStrToDatetime(json['birthDate']);
    _address = json['address'];
    _zipCode = json['zipCode'];
    _province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    _district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    _industry = json['industry'] != null
        ? new Industry.fromJson(json['industry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['surname'] = this._surname;
    data['userName'] = this._userName;
    data['email'] = this._email;
    data['location'] = this._location;
    data['password'] = this._password;
    data['about'] = this._about;
    data['headline'] = this._headline;
    data['website'] = this._website;
    data['birthDate'] = this._birthDate.toIso8601String();
    data['address'] = this._address;
    data['zipCode'] = this._zipCode;
    data['industryId'] = this.industry.industryId;
    data['provinceId'] = this.province.provinceId;
    data['districtId'] = this.district.districtId;
    return data;
  }
}
