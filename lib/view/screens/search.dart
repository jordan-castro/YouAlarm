import 'package:flutter/material.dart';
import 'package:youalarm/controller/load_sound.dart';
import 'package:youalarm/view/widgets/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SearchField(
        onSubmit: (query) {
          loadSoud(query);
        },
      ),
    );
  }
}
