import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taskproject/models/education/userEducation/user_education.dart';
import 'package:taskproject/models/education/userEducation/user_education_response.dart';
import 'package:taskproject/models/experience/experience.dart';
import 'package:taskproject/models/experience/experience_response.dart';
import 'package:taskproject/models/profile/profile_summary_model.dart';
import 'package:taskproject/models/publication/publication.dart';
import 'package:taskproject/models/publication/publication_response.dart';
import 'package:taskproject/models/skill/skill.dart';
import 'package:taskproject/models/skill/skill_response.dart';
import 'package:taskproject/screens/profile/accomplishments/section_accomplishment.dart';
import 'package:taskproject/screens/profile/experience/section_experiences.dart';
import 'package:taskproject/screens/profile/skill/section_skills.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/widgets/images/cached_images.dart';
import 'package:taskproject/widgets/progress_widget.dart';

import '../../router.dart';
import 'education/section_education.dart';

class ProfileScreen<T> extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  HttpService _httpService = HttpClient.getInstance();
  ProfileSummary _profileSummary;
  List<Experience> _experienceList;
  List<UserEducation> _userEducationList;
  List<Skill> _skillList = new List();
  List<Publication> _publicationList;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    _registerStreams();
    _loadPage();
    super.initState();
  }

  _loadPage() async {
    getProfileSummary();
    getExperienceList();
    getUserEducations();
    getUserSkills();
    getUserPublications();
    _refreshController.refreshCompleted();
  }

  _registerStreams() {
    BroadcastStream.getStream().stream.listen((data) {
      if (data.toString().compareTo(refreshProfileSkill) == 0) {
        getUserSkills();
      }
      if (data.toString().compareTo(refreshProfileSummary) == 0) {
        getProfileSummary();
      }
      if (data.toString().compareTo(refreshProfileEducation) == 0) {
        getUserEducations();
      }
      if (data.toString().compareTo(refreshProfileExperience) == 0) {
        getExperienceList();
      }
      if (data.toString().compareTo(refreshAccomplishments) == 0) {
        getUserPublications();
      }
    });
  }

  getProfileSummary() async {
    Response response = await _httpService.getProfileSummary();
    setState(() {
      _profileSummary = ProfileSummary.fromJson(response.data);
    });
  }

  getExperienceList() async {
    Response response = await _httpService.getExperiences();
    ExperienceResponse experienceResponse =
        ExperienceResponse.fromJsonArray(response.data);
    setState(() {
      _experienceList = experienceResponse.experienceList;
    });
  }

  getUserEducations() async {
    Response response = await _httpService.getUserEducations();
    UserEducationResponse userEducationResponse =
        UserEducationResponse.fromJsonArray(response.data);
    setState(() {
      _userEducationList = userEducationResponse.userEducationList;
    });
  }

  getUserSkills() async {
    Response response = await _httpService.getUserSkills();
    SkillResponse skillResponse = SkillResponse.fromJsonArray(response.data);
    setState(() {
      _skillList.clear();
      _skillList.addAll(skillResponse.skillList);
    });
  }

  getUserPublications() async {
    Response response = await _httpService.getUserPublications();
    PublicationResponse publicationResponse =
        PublicationResponse.fromJsonArray(response.data);
    setState(() {
      _publicationList = publicationResponse.publicationList;
    });
  }

  void _onRefresh() {
    _loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          header: MaterialClassicHeader(),
          enablePullDown: true,
          child: SingleChildScrollView(child: body())),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _profileSummary == null ? ProgressWidget() : profileTop(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _profileSummary == null ? ProgressWidget() : profileSummary(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: aboutSection(),
        ),
        experienceSection(),
        educationSection(),
        skillSection(),
        accomplishmentSection(),
      ],
    );
  }

  profileTop() {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_profile.png",
          width: double.infinity,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 16),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, enlargePProute,
                      arguments: _profileSummary.id);
                },
                child: Hero(
                    tag: 'pp',
                    child: CachedImages.getPPNetworkImage(
                        _profileSummary.id, 120))),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, editProfileRoute);
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ))
      ],
    );
  }

  Widget profileSummary() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _profileSummary.fullName,
          style: Theme.of(context).textTheme.title,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            _profileSummary.headline,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            _profileSummary.province.provinceName +
                " • " +
                _profileSummary.district.districtName,
            style: Theme.of(context).textTheme.display2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            _profileSummary.province.provinceName,
            style: Theme.of(context).textTheme.display2,
          ),
        )
      ],
    );
  }

  Widget aboutSection() {
    return getCard('About', () {
      Navigator.pushNamed(context, editAboutRoute,
          arguments: _profileSummary.about);
    },
        _profileSummary == null
            ? ProgressWidget()
            : Text(_profileSummary.about));
  }

  Widget skillSection() {
    return getCard(
      'Skills',
      () {
        Navigator.pushNamed(context, addSkillRoute);
      },
      _skillList == null
          ? ProgressWidget()
          : SectionSkills(
              skilList: _skillList,
            ),
    );
  }

  Widget accomplishmentSection() {
    return getCard(
      'Accomplishments',
      () {
        Navigator.pushNamed(context, addPublicationRoute);
      },
      _publicationList == null
          ? ProgressWidget()
          : SectionAccomplishments(
              publicationList: _publicationList,
            ),
    );
  }

  Widget experienceSection() {
    return getCard('Experience', () {
      Navigator.pushNamed(context, addExperienceRoute);
    },
        _experienceList == null
            ? ProgressWidget()
            : SectionExperiences(
                experienceList: _experienceList,
              ));
  }

  Widget educationSection() {
    return getCard('Education', () {
      Navigator.pushNamed(context, addEducationRoute);
    },
        _userEducationList == null
            ? ProgressWidget()
            : SectionEducation(
                userEducationList: _userEducationList,
              ));
  }

  Widget getCard(
    String title,
    VoidCallback onPress,
    Widget content,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.title,
                ),
                InkWell(
                    onTap: () {
                      onPress();
                    },
                    child: Icon(
                      Icons.add,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: content,
            )
          ],
        ),
      ),
    );
  }
}
