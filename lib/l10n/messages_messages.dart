// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "我的应用" : MessageLookupByLibrary.simpleMessage("我的应用"),
    "最低价" : MessageLookupByLibrary.simpleMessage("最低价："),
    "最高价" : MessageLookupByLibrary.simpleMessage("最高价："),
    "金汇行情" : MessageLookupByLibrary.simpleMessage("金汇行情")
  };
}