import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../common/common.dart';
import '../../../../constants/constants.dart';
import '../../../../icons/aspire_icons.dart';
import '../../../../models/states/app_state.dart';

class SaveSkillItem extends StatefulWidget {
  final bool editMode;
  final String skillId;
  
  SaveSkillItem({Key key, @required this.editMode, this.skillId}) 
    : super(key: key);

  @override
  _SaveSkillItemState createState() => _SaveSkillItemState();
}

class _SaveSkillItemState extends State<SaveSkillItem> {
  final GlobalKey<FormBuilderState> _saveSkillItemKey 
    = GlobalKey<FormBuilderState>();

  bool isSkillNameFocused, isExpertiseFocused;

  Store<AppState> store; 
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
   
    isSkillNameFocused = false;
    isExpertiseFocused = false;
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
        iconSize: screenHeight * 0.02,
        onPressed: () => {},
        icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).accentColor
          )
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          buildSkillsRow(),
          ...buildSaveSkillItemForm(),
          buildAddButton()
        ]
      )
    );
  }

  BoxDecoration buildSkillContainerDecoration({bool isFocused}) {
    return BoxDecoration(
      border: Border.all(
        color: isFocused ? ThemeColors.accent : Colors.grey,
        width: 1.0,
        style: BorderStyle.solid
      ),
      color: Colors.transparent,
      shape: BoxShape.rectangle, 
      borderRadius: BorderRadius.all(Radius.circular(20))
    );
  }

  Widget buildSkillContainer(isFocused) {
    return Container(
      height: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: screenWidth * 0.40,
      decoration: buildSkillContainerDecoration(isFocused: isFocused),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              icon: Icon(Icons.close, size: 12.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FormatText(text: "Photoshop", fontSize: 16.0, fontWeight: FontWeight.w300,),
              FormatText(text: "Intermediate", fontSize: 16.0, fontWeight: FontWeight.w200, textColor: Colors.grey)
            ]
          )
        ],
      ),
    );
  }

  Widget buildCenterAno() {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Column(
        children: <Widget>[
          Image.asset('images/onboarding/ano_standing.png', height: 60.0),
          Container(height: 1.5, width: 80, color: Colors.black),
        ]
      ),
    );
  }

  Widget buildSkillsRow() {
    return Container(
      padding: EdgeInsets.only(top: screenHeight * 0.20, bottom: 60.0),
      width: screenWidth,
      child: Row(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                buildCenterAno()
              ]
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  buildSkillContainer(true),
                  buildSkillContainer(false),
                  buildSkillContainer(false),
                ],
              )
            )
          )
        ]
      )
    );
  }

  Widget buildSkillField() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, left: 60.0, right: 60.0),
      child: FormBuilderTextField(
        attribute: 'school',
        maxLines: 1,
        style: fieldTextStyle(color: Theme.of(context).primaryColor),
        // onChanged: () => {},
        decoration: fieldDecoration(
          icon: AspireIcons.lock,
          hintText: addSkillHint,
          isFocused: isSkillNameFocused,
          isInvalid: false
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(30),
        ],
        keyboardType: TextInputType.text,
      )
    );
  }

  Widget buildExpertiseField() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, left: 60.0, right: 60.0),
      child: FormBuilderTextField(
        attribute: 'school',
        maxLines: 1,
        style: fieldTextStyle(color: Theme.of(context).primaryColor),
        // onChanged: () => {},
        decoration: fieldDecoration(
          icon: AspireIcons.lock,
          hintText: skillExpertiseHint,
          isFocused: isExpertiseFocused,
          isInvalid: false
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(30),
        ],
        keyboardType: TextInputType.text,
      )
    );
  }

  List<Widget> buildSaveSkillItemForm() {
    return <Widget>[
      FormBuilder(
        key: _saveSkillItemKey,
        child: Column(
          children: <Widget>[
            buildSkillField(),
            buildExpertiseField(),
          ]
        )
      ),
    ];
  }

  Widget buildAddButton() {
    return Container(
      padding: EdgeInsets.only(top:100.0, bottom: 20.0, 
      left: 60.0, right: 60.0),
      child: PrimaryButton(
        isLight: true,
        text: widget.editMode ? 'Edit' : 'Add',
        onPressed: () => {},
      )
    );
  }

}