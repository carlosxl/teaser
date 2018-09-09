import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/localizations.dart';
import 'package:my_project/containers/edit_list_box.dart';

class EditListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).editTitle),
            actions: <Widget>[
              PopupMenuButton<BatchEditType>(
                onSelected: (choice) {
                  store.dispatch(BatchEditAction(choice));
                },
                itemBuilder: (context) => <PopupMenuEntry<BatchEditType>>[
                      PopupMenuItem(
                        value: BatchEditType.ShowAll,
                        child: Text(AppLocalizations.of(context).showAll),
                      ),
                      PopupMenuItem(
                        value: BatchEditType.HideAll,
                        child: Text(AppLocalizations.of(context).hideAll),
                      )
                    ],
              ),
            ],
          ),
          body: EditListBox(),
        );
      },
    );
  }
}
