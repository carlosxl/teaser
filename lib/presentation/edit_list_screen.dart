import 'package:flutter/material.dart';

import 'package:my_project/localizations.dart';
import 'package:my_project/containers/edit_list_box.dart';

class EditListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).editTitle)
      ),
      body: EditListBox(),
    );
  }
}
