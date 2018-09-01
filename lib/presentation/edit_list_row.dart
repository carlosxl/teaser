import 'package:flutter/material.dart';

import 'package:my_project/models/market_data.dart';

class EditListRow extends StatelessWidget {
  final MarketData data;
  final onToggle;


  EditListRow({Key key, this.data, this.onToggle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: data.isVisible,
      title: Text(data.name),
      controlAffinity: ListTileControlAffinity.leading,
      secondary: Icon(Icons.reorder),
      onChanged: (bool value) {
        onToggle(data.name, value);
      },
    );
  }
}
