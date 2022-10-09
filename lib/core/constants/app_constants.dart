import 'package:flutter/material.dart';

class ApplicationConstants {
  static const appName = "News App";
  String _baseURL = "http://192.168.1.8:3000";
  static BorderRadiusGeometry borderRadius = BorderRadius.circular(6);
  get baseURL => _baseURL;
  setbaseURL(String url) {
    _baseURL = url;
  }
}
