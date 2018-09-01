import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:my_project/actions/actions.dart';
import 'package:my_project/models/app_store.dart';
import 'package:my_project/presentation/edit_list_row.dart';

class EditListBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return ReorderableListView(
          children: _buildList(context, store),
          onReorder: (oldIndex, newIndex) {
            store.dispatch(ReorderAction(oldIndex, newIndex));
          },
        );
      },
    );
  }

  List<Widget> _buildList(BuildContext context, Store<AppState> store) {
    onToggle(String name, bool value) {
      store.dispatch(ToggleVisibilityAction(name, value));
    }

    return store.state.marketDataList
        .map((data) => EditListRow(
              key: Key(data.name),
              data: data,
              onToggle: onToggle,
            ))
        .toList();
  }
}
