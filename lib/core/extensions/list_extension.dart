import 'package:flutter/material.dart';

extension ListW on List<Widget> {
  List<Widget> gap({required double space}) => map((e) =>
          Padding(padding: EdgeInsets.symmetric(vertical: space), child: e))
      .toList();
}

extension ListX on List {
  List<T> replace<T>(int index, T data) =>
      List.from(this)..replaceRange(index, index + 1, [data]);
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}