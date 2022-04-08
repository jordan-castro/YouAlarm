import 'package:flutter/material.dart';
import 'package:youalarm/model/sounds_model.dart';
import 'package:youalarm/view/widgets/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SearchField(
        onSubmit: (query) {
          SoundsModel.of(context, listen: false).downloadNewSound(query);
        },
      ),
    );
  }
}
