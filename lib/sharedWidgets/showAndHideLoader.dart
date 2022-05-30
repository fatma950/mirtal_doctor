// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:mirtal_doctor/sharedWidgets/materialTransparentRoute.dart';

import 'loader.dart';

bool loading = false;

showLoading(BuildContext context) {
  if (!loading) {
    loading = true;

    Navigator.of(context).push(MaterialTransparentRoute(
        builder: (BuildContext context) => const Loader()));
  }
}

hideLoading(BuildContext context) {
  if (loading) {
    Navigator.pop(context);
    loading = false;
  }
}
