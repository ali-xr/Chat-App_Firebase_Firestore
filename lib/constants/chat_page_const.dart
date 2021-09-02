import 'package:flutter/material.dart';

const kSendMessageTextStyle = TextStyle(
  color: Colors.deepOrangeAccent,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);
const kMessageSendTextFieldStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: "Type Message....",
    hintStyle: TextStyle(color: Colors.black),
    border: InputBorder.none);
const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
const kOngTomon = BorderRadius.only(
  topRight: Radius.circular(30),
  topLeft: Radius.circular(30),
  bottomLeft: Radius.circular(30),
  // bottomRight: Radius.circular(30),
);

const kChapTomon = BorderRadius.only(
  topRight: Radius.circular(30),
  bottomLeft: Radius.circular(30),
  bottomRight: Radius.circular(30),
);
