import 'package:flutter/material.dart';

extension NumX on num {
  //SizedBox to add vertical spacing
  SizedBox get vSizedBox => SizedBox(height: toDouble());

  //SizedBox to add horizontal spacing
  SizedBox get hSizedBox => SizedBox(width: toDouble());
}
