import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/models/skill/skill.dart';
import 'package:taskproject/models/skill/skill_response.dart';
import 'package:taskproject/service/http_client.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/broadcast_stream.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/status_codes.dart';
import 'package:taskproject/widgets/chips/skill_clip.dart';
import 'package:taskproject/widgets/forms/cupertino_search_bar.dart';
import 'package:taskproject/widgets/progress_widget.dart';

class AddSkilScreen extends StatefulWidget {
  @override
  _AddSkilScreenState createState() => _AddSkilScreenState();
}

class _AddSkilScreenState extends State<AddSkilScreen>
    with SingleTickerProviderStateMixin {
  HttpService _httpService = HttpClient.getInstance();
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  String _searchTextInProgress;
  List<Skill> _skillList = new List();
  List<Skill> _skillListFiltered = new List();
  bool _isSending = false;
  Skill _selectedSkill;
  @override
  initState() {
    super.initState();
    _getSkillList();
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });

    _searchTextController.addListener(_performSearch);
  }

  _getSkillList() async {
    Response response = await _httpService.getAllUserSkills();
    SkillResponse skillResponse = SkillResponse.fromJsonArray(response.data);
    _skillList = skillResponse.skillList;
    _skillListFiltered.addAll(skillResponse.skillList);
    setState(() {});
  }

  Future<bool> _removeUserSkill(int skillId) async {
    var resp = await _httpService.deleteUserSkill(skillId);
    if (resp.statusCode == StatusCodes.ok) {
      _refreshProfileSkills();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _addUserSkill(int skillId) async {
    var resp = await _httpService.addUserSkill(skillId);
    if (resp.statusCode == StatusCodes.ok) {
      _refreshProfileSkills();
      return true;
    } else
      return false;
  }

  _refreshProfileSkills() {
    sendBroadcastMessage(refreshProfileSkill);
  }

  _performSearch() {
    final text = _searchTextController.text;

    if (text == _searchTextInProgress) {
      return;
    }

    if (text.isEmpty) {
      this.setState(() {
        _searchTextInProgress = null;
        removeFilter();
      });
      return;
    }

    this.setState(() {
      _searchTextInProgress = text;
      if(_skillListFiltered.length>0) _skillListFiltered.clear();
      for (var item in _skillList) {
        if (item.skillName.toLowerCase().contains(text.toLowerCase())) {
          _skillListFiltered.add(item);
        }
      }
    });
  }

  _cancelSearch() {
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
    this.setState(() {
      _searchTextInProgress = null;
    });
  }

  _clearSearch() {
    _searchTextController.clear();
    this.setState(() {
      _searchTextInProgress = null;
      removeFilter();
    });
  }

  removeFilter() {
    if(_skillListFiltered.length>0) _skillListFiltered.clear();
    _skillListFiltered.addAll(_skillList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Skills'),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )),
      body: _skillList.length == 0
          ? ProgressWidget()
          : SingleChildScrollView(child: body()),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: <Widget>[
          IOSSearchBar(
            controller: _searchTextController,
            focusNode: _searchFocusNode,
            animation: _animation,
            onCancel: _cancelSearch,
            onClear: _clearSearch,
          ),
          Wrap(
            spacing: 4.0,
            runSpacing: -8.0,
            children: <Widget>[
              for (var item in _skillListFiltered) getSkillChip(item)
            ],
          ),
        ],
      ),
    );
  }

  getSkillChip(Skill skill) {
    return SkillChip(
      onChanged: (value) async {
        _selectedSkill = skill;
        setState(() {
          _isSending = true;
        });
        if (value == true) {
          if ((await _addUserSkill(skill.skillId))) {
            skill.isSelected = true;
          }
        } else {
          if ((await _removeUserSkill(skill.skillId))) {
            skill.isSelected = false;
          }
        }
        _isSending = false;
        setState(() {});
      },
      skill: skill,
    );
  }
}
