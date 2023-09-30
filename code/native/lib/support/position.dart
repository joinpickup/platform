import 'package:flutter/material.dart';

Offset getOffsetFromKey(GlobalKey key) {
  RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero);
}

Size getSizeFromKey(GlobalKey key) {
  RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
  return box.size;
}
